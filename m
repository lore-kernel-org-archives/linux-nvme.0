From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 19:21:29 +0300
Subject: kernel NULL pointer during reset_controller operation with IO on
 4.11.0-rc7
In-Reply-To: <1413097100.14743757.1492668219336.JavaMail.zimbra@redhat.com>
References: <1413097100.14743757.1492668219336.JavaMail.zimbra@redhat.com>
Message-ID: <97bb90ec-4337-62f7-f08d-a673975a5637@grimberg.me>


> [1]
> [ 5968.515237] DMAR: DRHD: handling fault status reg 2
> [ 5968.519449] mlx5_2:dump_cqe:262:(pid 0): dump error cqe
> [ 5968.519450] 00000000 00000000 00000000 00000000
> [ 5968.519451] 00000000 00000000 00000000 00000000
> [ 5968.519451] 00000000 00000000 00000000 00000000
> [ 5968.519452] 00000000 02005104 00000316 a71710e3

Max, Can you decode this for us?
