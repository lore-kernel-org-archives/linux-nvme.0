From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 27 Feb 2017 22:13:46 +0200
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
Message-ID: <7267b601-e436-570a-a103-65ffeb6e7a97@grimberg.me>


> Hi,
>
> I will try with kernel 4.10 when I get my hands on the machine.
>
> In addition, I found that the machine did not have the kernel-firmware
> package installed. Could this cause the "strange" CX4 behavior? I will
> obviously re-test with the kernel-firmware package.

Not really, Mellanox FW is obtained by mellanox provided tools.
