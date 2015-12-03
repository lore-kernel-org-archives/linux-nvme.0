From: asb@cin.ufpe.br (Angelo Brito)
Date: Thu, 3 Dec 2015 18:35:55 -0500
Subject: IRQ and CPU Affinity on new Kernels
Message-ID: <CAMjVwgQRoPi8Chta3sXdxAZX3KCsQOu9fqRvL_i9qRqg1BkFmQ@mail.gmail.com>

Hello Gentlemen,

We had some problems with a controller and some commands were missing
(timeouts and cancelling I/O).
I noticed that some interruptions were handled by different CPUs, like
in this example:

[root at schenberg ~]# uname -a
Linux schenberg 4.3.0-1.el7.elrepo.x86_64 #1 SMP Tue Nov 3 20:15:39
EST 2015 x86_64 x86_64 x86_64 GNU/Linux
[root at schenberg ~]# cat /proc/interrupts | grep nvme
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
      CPU6       CPU7
 38:  158075552          0          0          0          3          0
         0          0  IR-PCI-MSI 524288-edge      nvme0q0, nvme0q1
 39:          0  155369176          0          0          0          0
         0          0  IR-PCI-MSI 524289-edge      nvme0q2
 40:          0          0  166645563          0          0          0
         0          0  IR-PCI-MSI 524290-edge      nvme0q3
 41:          0          0          0  185969937          0          0
         0          0  IR-PCI-MSI 524291-edge      nvme0q4
 42:          1          0          0          0   91441357          1
         0          0  IR-PCI-MSI 524292-edge      nvme0q5
 43:          0          0          0          0          0   92262534
         0          0  IR-PCI-MSI 524293-edge      nvme0q6
 44:          0          0          0          0          0          0
  96782665          0  IR-PCI-MSI 524294-edge      nvme0q7
 45:          0          0          0          0          0          0
         0   79111494  IR-PCI-MSI 524295-edge      nvme0q8

nvme0q0, nvme0q1 interrupted the host and CPU4 3 times and nvme0q5
interrupts were handled by CPU0, CPU4 and CPU5.

Is it a common behavior? Why would others CPU handles interrupts from
the not corresponding Completion Queue?

Regards,
Angelo Silva Brito.
B.S. in Computer Engineering - UFPE Brazil
http://about.me/angelobrito
_________________________________________________
