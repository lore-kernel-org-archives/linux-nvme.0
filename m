From: gil.shomron@gmail.com (Gil Shomron)
Date: Thu, 21 Jul 2016 13:36:37 +0300
Subject: Bandwidth issues and blktrace debug
Message-ID: <CA+-kpaTvU+5vbqk536ajVSxwKSfa+c_4Ks5wv4iaee7UfcOnqA@mail.gmail.com>

Hi all,

I have Intel's P3700 SSD mounted on a Lenovo x3650 M5 server with two
Intel Xeon E5-2630 v3 CPUs. The server is running Ubuntu 14.04 with
4.6.4 Kernel.

I've been using fio to benchmark the SSD using a synchronous
sequential reads with 1MB block size. Bandwidth result is ~1.6GB/sec.
This is relatively small to the maximum 2.8GB/sec it should be. I did
witnessed a P3700 reaches this bandwidth with a similar benchmark on a
high-end PC.

This is the fio command I'm using
sudo fio --time_based --name=benchmark --size=1G --runtime=15
--blocksize=1M --ioengine=sync --randrepeat=0 --iodepth=1 --direct=1
--sync=1 --verify_fatal=0 --numjobs=1 --rw=read --group_reporting

Trying to debug this I've installed blktrace, and ran it on my server
and on the high-end PC for comparison. see below.

Notice that on the server there are a bunch of splits (X) while the PC
doesn't have them, and on the server there is a mismatch between the
queued and dispatched requests (on the end). What is it?

Server trace (bad):
259,0    0    94207     1.353041898  1597  A   R 410329088 + 2048 <-
(259,1) 410327040
259,1    0    94208     1.353042039  1597  Q   R 410329088 + 2048 [fio]
259,1    0    94209     1.353042709  1597  X   R 410329088 / 410329344 [fio]
259,1    0    94210     1.353042800  1597  Q   R 410329344 + 1792 [fio]
259,1    0    94211     1.353042938  1597  G   R 410329088 + 256 [fio]
259,1    0    94212     1.353043649  1597  X   R 410329344 / 410329600 [fio]
259,1    0    94213     1.353043735  1597  Q   R 410329600 + 1536 [fio]
259,1    0    94214     1.353043799  1597  G   R 410329344 + 256 [fio]
259,1    0    94215     1.353044905  1597  D  RS 410329088 + 256 [fio]
259,1    0    94216     1.353045604  1597  X   R 410329600 / 410329856 [fio]
259,1    0    94217     1.353045690  1597  Q   R 410329856 + 1280 [fio]
259,1    0    94218     1.353045879  1597  G   R 410329600 + 256 [fio]
259,1    0    94219     1.353046790  1597  D  RS 410329344 + 256 [fio]
259,1    0    94220     1.353047486  1597  X   R 410329856 / 410330112 [fio]
259,1    0    94221     1.353047573  1597  Q   R 410330112 + 1024 [fio]
259,1    0    94222     1.353047638  1597  G   R 410329856 + 256 [fio]
259,1    0    94223     1.353048579  1597  D  RS 410329600 + 256 [fio]
259,1    0    94224     1.353049292  1597  X   R 410330112 / 410330368 [fio]
259,1    0    94225     1.353049378  1597  Q   R 410330368 + 768 [fio]
259,1    0    94226     1.353049443  1597  G   R 410330112 + 256 [fio]
259,1    0    94227     1.353050335  1597  D  RS 410329856 + 256 [fio]
259,1    0    94228     1.353051032  1597  X   R 410330368 / 410330624 [fio]
259,1    0    94229     1.353051118  1597  Q   R 410330624 + 512 [fio]
259,1    0    94230     1.353051184  1597  G   R 410330368 + 256 [fio]
259,1    0    94231     1.353052124  1597  D  RS 410330112 + 256 [fio]
259,1    0    94232     1.353052830  1597  X   R 410330624 / 410330880 [fio]
259,1    0    94233     1.353052915  1597  Q   R 410330880 + 256 [fio]
259,1    0    94234     1.353052982  1597  G   R 410330624 + 256 [fio]
259,1    0    94235     1.353053918  1597  D  RS 410330368 + 256 [fio]
259,1    0    94236     1.353054583  1597  G   R 410330880 + 256 [fio]
259,1    0    94237     1.353055518  1597  D  RS 410330624 + 256 [fio]
259,1    0    94238     1.353055809  1597  U   N [fio] 1
259,1    0    94239     1.353055885  1597  I  RS 410330880 + 256 [fio]
259,1    0    94240     1.353056752  1597  D  RS 410330880 + 256 [fio]
259,1    0    94241     1.353479359     0  C  RS 410329344 + 256 [0]
259,1    0    94242     1.353485238     0  C  RS 410329088 + 256 [0]
259,1    0    94243     1.353492491     0  C  RS 410329600 + 256 [0]
259,1    0    94244     1.353520227     0  C  RS 410330368 + 256 [0]
259,1    0    94245     1.353569613     0  C  RS 410330880 + 256 [0]
259,1    0    94246     1.353574450     0  C  RS 410329856 + 256 [0]
259,1    0    94247     1.353578150     0  C  RS 410330112 + 256 [0]
259,1    0    94248     1.353585196     0  C  RS 410330624 + 256 [0]
...
Total (259,1):
 Reads Queued:      199808,   115089MiB  Writes Queued:           0,        0KiB
 Read Dispatches:   199808,    25575MiB  Write Dispatches:        0,        0KiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:   199808,    25575MiB  Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 IO unplugs:         24976               Timer unplugs:           0


PC trace (good):
259,0    2    57721     8.845611892 25106  Q   R 288768 + 256 [fio]
259,0    2    57722     8.845612054 25106  G   R 288768 + 256 [fio]
259,0    2    57723     8.845613129 25106  D  RS 288768 + 256 [fio]
259,0    2    57724     8.845615758 25106  Q   R 289024 + 256 [fio]
259,0    2    57725     8.845615829 25106  G   R 289024 + 256 [fio]
259,0    2    57726     8.845616781 25106  D  RS 289024 + 256 [fio]
259,0    2    57727     8.845618483 25106  Q   R 289280 + 256 [fio]
259,0    2    57728     8.845618535 25106  G   R 289280 + 256 [fio]
259,0    2    57729     8.845619400 25106  D  RS 289280 + 256 [fio]
259,0    2    57730     8.845621996 25106  Q   R 289536 + 256 [fio]
259,0    2    57731     8.845622051 25106  G   R 289536 + 256 [fio]
259,0    2    57732     8.845622699 25106  D  RS 289536 + 256 [fio]
259,0    2    57733     8.845624389 25106  Q   R 289792 + 256 [fio]
259,0    2    57734     8.845624452 25106  G   R 289792 + 256 [fio]
259,0    2    57735     8.845625047 25106  D  RS 289792 + 256 [fio]
259,0    2    57736     8.845627636 25106  Q   R 290048 + 256 [fio]
259,0    2    57737     8.845627709 25106  G   R 290048 + 256 [fio]
259,0    2    57738     8.845628294 25106  D  RS 290048 + 256 [fio]
259,0    2    57739     8.845629988 25106  Q   R 290304 + 256 [fio]
259,0    2    57740     8.845630042 25106  G   R 290304 + 256 [fio]
259,0    2    57741     8.845630593 25106  D  RS 290304 + 256 [fio]
259,0    2    57742     8.845632278 25106  Q   R 290560 + 256 [fio]
259,0    2    57743     8.845632332 25106  G   R 290560 + 256 [fio]
259,0    2    57744     8.845633114 25106  D  RS 290560 + 256 [fio]
259,0    2    57745     8.846056151     0  C  RS 289024 + 256 [0]
259,0    2    57746     8.846066912     0  C  RS 289280 + 256 [0]
259,0    2    57747     8.846095809     0  C  RS 289536 + 256 [0]
259,0    2    57748     8.846130757     0  C  RS 290048 + 256 [0]
259,0    2    57749     8.846141543     0  C  RS 289792 + 256 [0]
259,0    2    57750     8.846148906     0  C  RS 288768 + 256 [0]
259,0    2    57751     8.846173043     0  C  RS 290560 + 256 [0]
259,0    2    57752     8.846180066     0  C  RS 290304 + 256 [0]
...
Total (259,0):
 Reads Queued:       88156,    11283MiB  Writes Queued:        8214,     1048MiB
 Read Dispatches:    88155,    11283MiB  Write Dispatches:     8214,     1048MiB
 Reads Requeued:         0               Writes Requeued:         0
 Reads Completed:    88153,    11283MiB  Writes Completed:     8214,     1048MiB
 Read Merges:            0,        0KiB  Write Merges:            0,        0KiB
 IO unplugs:             0               Timer unplugs:           0


Can you please advise?

Thanks,
   Gil.
