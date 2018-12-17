From: albi.schlegel@hotmail.com (Albert Schlegel)
Date: Mon, 17 Dec 2018 15:33:19 +0000
Subject: AW: NVMe drive kernel fail after hotplug kernel 4.16.12
In-Reply-To: <20181203142725.GA14775@localhost.localdomain>
References: <AM6PR03MB4038E7290A514371F9D60E17F87F0@AM6PR03MB4038.eurprd03.prod.outlook.com>
 <AM6PR03MB4038A5FDD819AE34DDDE54A4F87E0@AM6PR03MB4038.eurprd03.prod.outlook.com>
 <20180613151128.GB5574@localhost.localdomain>
 <AM6PR03MB40389E7C34537DF6CCDF0904F8400@AM6PR03MB4038.eurprd03.prod.outlook.com>
 <B58D82457FDA0744A320A2FC5AC253B978F0A162@fmsmsx104.amr.corp.intel.com>
 <SN6PR07MB42219ADDE6D4E35F953A4A90F8AE0@SN6PR07MB4221.namprd07.prod.outlook.com>,
 <20181203142725.GA14775@localhost.localdomain>
Message-ID: <SN6PR07MB42219590FA5D48764DDD5E26F8BC0@SN6PR07MB4221.namprd07.prod.outlook.com>

Hi Keith,

the suggested fix solves our problem.

Many thanks!

Von: Keith Busch <keith.busch at intel.com>
Gesendet: Montag, 3. Dezember 2018 15:27
An: Albert Schlegel
Cc: linux-nvme at lists.infradead.org
Betreff: Re: NVMe drive kernel fail after hotplug kernel 4.16.12
?
On Mon, Dec 03, 2018@02:50:44AM -0800, Albert Schlegel wrote:
> Hi Keith,
>
> unfornately your commit does not fix our problem. Now we get a NULL pointer dereference.
> We tested the kernel? 4.20-rc3 and got the following output after power fail of the nvme device:

You're talking about a different problem. Alex reported this regression
after 4.20-rc2, and Igor wrote the fix(*) committed in 4.20-rc4. Try
that one.

?* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=751a0cc0cd3a0d51e6aaf6fd3b8bd31f4ecfaf3e
