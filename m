From: keith.busch@intel.com (Keith Busch)
Date: Wed, 9 Sep 2015 16:30:20 +0000 (UTC)
Subject: [PATCH] NVMe: Force cancel commands on hot-removal
In-Reply-To: <CAPYzm7Sspbga3DkAyKC_gq1Y_2Em9GEE8mdn5x_0Z=-vXyZQVg@mail.gmail.com>
References: <1441743187-12277-1-git-send-email-keith.busch@intel.com>
 <CAPYzm7Sm4K-VVWxGLAD2sjJ_e=FL3aQor8npN4sVcJ6irBtzJg@mail.gmail.com>
 <CAPYzm7RB-LqEW1f0e-_Sh_ui3vS6q3sEOQ7sk5xfsOEG9SOVmg@mail.gmail.com>
 <alpine.LNX.2.00.1509091339130.23840@localhost.lm.intel.com>
 <CAPYzm7Sspbga3DkAyKC_gq1Y_2Em9GEE8mdn5x_0Z=-vXyZQVg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1509091620350.23840@localhost.lm.intel.com>

On Wed, 9 Sep 2015, Mohana Goli wrote:
> I ran another test after creating filesystem on the nvme
> devices.Unfortunately i have seen the IO Timeouts again.
> I used the following steps:

I guess we need stop the h/w queues first, then. I thought killing it
would have sufficed, but inflight commands will make it to the driver.
