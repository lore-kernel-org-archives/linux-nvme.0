From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Sep 2017 14:15:58 +0300
Subject: nvmeof rdma regression issue on 4.14.0-rc1 (or maybe mlx4?)
In-Reply-To: <e44f4640-44b2-4692-ca57-08f9ebf4da2c@redhat.com>
References: <1735134433.8514119.1505997532669.JavaMail.zimbra@redhat.com>
 <1215229914.8516804.1505998051674.JavaMail.zimbra@redhat.com>
 <20170921144421.GA15285@infradead.org>
 <47493aa0-4cad-721b-4ea2-c3b2293340aa@grimberg.me>
 <e8aa9f2e-14b1-23f0-f672-07a913842c9d@redhat.com>
 <20170924103426.GB25094@mtr-leonro.local>
 <4d0e27f2-99e4-ffc7-18a5-e5757c27dad4@redhat.com>
 <4faccebf-7fcf-58b9-1605-82ee9acc652b@grimberg.me>
 <e44f4640-44b2-4692-ca57-08f9ebf4da2c@redhat.com>
Message-ID: <54a2215f-f439-4ccc-11a9-4e3e4ad334f9@grimberg.me>


> Here is the log, didn't get the error log, but the nvme0n1 device node 
> also doesn't exist on host.

That's because the identifiers changed maybe? did you have nvm0n2 instead?

> Yes, I can reproduce every time. And the target side kernel version is 
> 4.14.0-rc1 during the panic occurred.

What is the host side kernel version? doesn't look like 4.14.0-rc1
