# Self-check for task 3. Run from assignments/automata-peg: janet peg/test.janet

(import ../check :prefix "")
(import ./command)

(def accepted
  [# add: title, tags, due date with optional time, duration
   [`add "Read Sipser"`
    {:command :add :title "Read Sipser" :tags []}]
   [`add Read Sipser`
    {:command :add :title "Read Sipser" :tags []}]
   [`add "Read \"Sipser\" ch. 1" #ti #exam due 2026-12-03 at 14:30 for 1h30m`
    {:command :add :title `Read "Sipser" ch. 1` :tags ["ti" "exam"]
     :date {:year 2026 :month 12 :day 3} :time {:hour 14 :minute 30} :duration 90}]
   [`add "C:\\temp" due 2026-01-09`
    {:command :add :title `C:\temp` :tags [] :date {:year 2026 :month 1 :day 9}}]
   [`add Write lab report #ti for 45m`
    {:command :add :title "Write lab report" :tags ["ti"] :duration 45}]
   [`add Read about duet #music`
    {:command :add :title "Read about duet" :tags ["music"]}]
   [`add "Meet at noon" for 2h`
    {:command :add :title "Meet at noon" :tags [] :duration 120}]
   [`add "#1 priority" #a-1`
    {:command :add :title "#1 priority" :tags ["a-1"]}]
   [`add Pay rent due 2026-02-31`
    {:command :add :title "Pay rent" :tags [] :date {:year 2026 :month 2 :day 31}}]
   [`add  Spaced   out  title   #x   due  2026-12-31   for 0m  `
    {:command :add :title "Spaced   out  title" :tags ["x"]
     :date {:year 2026 :month 12 :day 31} :duration 0}]
   # start and stop: optional time
   [`start "TI seminar" #ti #culs`
    {:command :start :title "TI seminar" :tags ["ti" "culs"]}]
   [`start Lab at 09:15`
    {:command :start :title "Lab" :tags [] :time {:hour 9 :minute 15}}]
   [`start Lab at9:15`
    {:command :start :title "Lab at9:15" :tags []}]
   [`start "Lab" at 23:59`
    {:command :start :title "Lab" :tags [] :time {:hour 23 :minute 59}}]
   [`stop`
    {:command :stop}]
   [`stop at 00:00`
    {:command :stop :time {:hour 0 :minute 0}}]
   # done: a positive id
   [`done 7`
    {:command :done :id 7}]
   [`done 120`
    {:command :done :id 120}]
   # list: optional range, then tags
   [`list`
    {:command :list :tags []}]
   [`list week #ti`
    {:command :list :range :week :tags ["ti"]}]
   [`list today`
    {:command :list :range :today :tags []}]
   [`list all #ti #exam`
    {:command :list :range :all :tags ["ti" "exam"]}]
   [`list #week`
    {:command :list :tags ["week"]}]])

(def rejected
  [# whole-word keywords
   `address book`
   `listing`
   `stopped`
   `list weekly`
   # titles
   `add`
   `add ""`
   `add "unterminated`
   `add "bad \n escape"`
   `add "glued"#ti`
   `add Meet at noon`
   `add #ti`
   # tags
   `add Lab #TI`
   `add Lab #ti#x`
   `add Lab #`
   # dates, times and durations
   `add Lab due 2026-13-01`
   `add Lab due 2026-12-00`
   `add Lab due 2026-12-32`
   `add Lab due 26-12-01`
   `add Lab at 10:00`
   `start Lab at 24:00`
   `start Lab at 9:15`
   `start Lab at 10:60`
   `add Lab for 1m30h`
   `add Lab for 90`
   `add Lab for 1h30`
   # fixed order of optional parts
   `add Lab for 1h due 2026-12-03`
   `add Lab due 2026-12-03 #ti`
   `list #ti week`
   # done ids, stop and trailing text
   `done 0`
   `done 07`
   `done`
   `done 7 more`
   `stop now`
   `stop #ti`
   `Add Lab`])

(each [line expected] accepted
  (check (string/format "parse %q" line)
         (is expected (freeze (command/parse line)))))

(each line rejected
  (check (string/format "parse %q is nil" line)
         (is nil (command/parse line))))

(report)
