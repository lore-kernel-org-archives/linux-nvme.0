From: joshua_mora@usa.net (Joshua Mora)
Date: Sun, 15 Jan 2017 19:33:26 -0600
Subject: nvme queue load balanced distribution of requests
Message-ID: <259VaPBGA7184S06.1484530406@web06.cms.usa.net>

Hello.
I am benchmarking different NVMEs that have 8, 16 or upto 32 queues.
Despite I provide a queue depth in the benchmark (like fio) and also run
concurrently multiple threads to different files to the same NVME (ie.
multiple jobs), I do not succeed to use all those queues.
Is there any parameter somewhere to configure that ?
It that issuing of requests controlled by the nvme driver ?
Is there also any documentation about parameters that can be passed to the
NVME driver to improve the response time, to set max power,... ?
I would be interested in those settings for Linux and for Windows.
If this is not about settings but about meeting some requirements during
execution to issue the requests to different queues, I would be interested to
understand that as well.
If you can point me to the specific information that has influence on the
performance of requests, I would be very interested to know about it.
The main goal is to try to achieve the highest IOPs while reading at short
record length (~4KB) with the few amount of CPU cycles with the fewest amount
of cores but as many as needed to maxout the capabilities of the NVME
devices.
Additionally, in order to reduce CPU cycles utilization, is there a
"coalescing" mechanism as well to dial the amount of CPU intervention to
interrupt requests ?

If the above questions are more suited to a different distribution
list/newsgroup, please let me know as well.

Thanks in advance,
Joshua
