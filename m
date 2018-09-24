From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 23 Sep 2018 21:27:07 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <20180920071040.GA8685@infradead.org>
References: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
 <20180920071040.GA8685@infradead.org>
Message-ID: <6b1a7562-2aa1-c5ff-5dd4-c7a6f7af3697@grimberg.me>


>> Hello,
>>
>> If I run the nvmeof-mp tests from https://github.com/bvanassche/blktests
>> against kernel v4.19-rc4 then a KASAN complaint appears. This complaint does
>> not appear when I run these tests against kernel v4.18. Could this be a
>> regression?
> 
> Sounds like it is.  4.19 has the new ANA code, so the multipath code
> has some churn.

Note that this is testing nvmf with dm-multipath.

>> BUG: KASAN: use-after-free in srcu_invoke_callbacks+0x207/0x290
> 
> Can you resolve the address using gdb on vmlinux to a specific
> line of code?

Did this get resolved?
Bart, did this reproduce with nvme.multipath=1? or was it disabled?
