From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 29 Jul 2019 10:17:10 -0600
Subject: [PATCH v6 00/16] nvmet: add target passthru commands support
In-Reply-To: <322df1b1-dbba-2018-44da-c108336f8d55@grimberg.me>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
 <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
 <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
 <e166c392-1548-f0bb-02bc-ced3dd85f301@grimberg.me>
 <1260e01c-6731-52f7-ae83-0b90e0345c68@deltatee.com>
 <6DF00EEF-5A9D-49C9-A27C-BE34E594D9A9@raithlin.com>
 <322df1b1-dbba-2018-44da-c108336f8d55@grimberg.me>
Message-ID: <f4e551fe-f081-26d2-5a6a-46f826640189@deltatee.com>



On 2019-07-29 10:15 a.m., Sagi Grimberg wrote:
> 
>>> This is different from multipath on say a multi-controller PCI device
>>> and trying to expose both those controllers through passthru. this is
>>> where the problems we are discussing come up.
>>
>> I *think* there is some confusion. I *think* Sagi is talking about network multi-path (i.e. the ability for the host to connect to a controller on the target via two different network paths that fail-over as needed). I *think* Logan is talking about multi-port PCIe NVMe devices that allow namespaces to be accessed via more than one controller over PCIe (dual-port NVMe SSDs being the most obvious example of this today).
> 
> Yes, I was referring to fabrics multipathing which is somewhat
> orthogonal to the backend pci multipathing (unless I'm missing
> something).

Yes, so if we focus on the fabrics multipathing, the only issue I see is
that only one controller can be connected to a passthru target (I
believe this was at your request) so two paths simply cannot exist to
begin with. I can easily remove that restriction.

Logan
