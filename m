From: sbates@raithlin.com (Stephen  Bates)
Date: Sat, 27 Jul 2019 00:50:47 +0000
Subject: [PATCH v6 00/16] nvmet: add target passthru commands support
In-Reply-To: <1260e01c-6731-52f7-ae83-0b90e0345c68@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
 <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
 <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
 <e166c392-1548-f0bb-02bc-ced3dd85f301@grimberg.me>
 <1260e01c-6731-52f7-ae83-0b90e0345c68@deltatee.com>
Message-ID: <6DF00EEF-5A9D-49C9-A27C-BE34E594D9A9@raithlin.com>

> This is different from multipath on say a multi-controller PCI device
> and trying to expose both those controllers through passthru. this is
> where the problems we are discussing come up.

I *think* there is some confusion. I *think* Sagi is talking about network multi-path (i.e. the ability for the host to connect to a controller on the target via two different network paths that fail-over as needed). I *think* Logan is talking about multi-port PCIe NVMe devices that allow namespaces to be accessed via more than one controller over PCIe (dual-port NVMe SSDs being the most obvious example of this today).

> But it's the multipath through different ports that
>  seems important for fabrics. ie. If I have a host with a path through
>  RDMA and a path through TCP they should both work and allow fail over.

Yes, or even two paths that are both RDMA or both TCP but which take a different path through the network from host to target.

> Our real-world use case is to support our PCI device which has a bunch
> of vendor unique commands and isn't likely to support multiple
> controllers in the foreseeable future.

I think solving passthru for single-port PCIe controllers would be a good start.

Stephen
