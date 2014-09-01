From: harryxiyou@gmail.com (harryxiyou)
Date: Tue, 2 Sep 2014 01:10:15 +0800
Subject: NVMe multi-core process
Message-ID: <CAD+1EGN1P1=0Le0Z7Cd3WdC5Q3+Eca+SKFpzdfEQwpqg3LhR=w@mail.gmail.com>

Dear Keith,

I saw following words in the NVMe specification but I cannot see the
related codes
in the linux NVMe driver.

"Typically the number of command queues created is based on the system
configuration and anticipated workload. For example, on a four core
processor based system, there may be a queue pair per core to avoid
locking and ensure data structures are created in the appropriate
processor core?s cache."


I don't know how to configure NVMe to run it on multiple cores?


Thanks, Harry
