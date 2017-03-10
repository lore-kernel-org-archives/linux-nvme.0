From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 10 Mar 2017 13:56:47 +0200
Subject: [PATCH RFC 0/4] nvme-fabrics: TCP transport
In-Reply-To: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
References: <ecf773d2-beb9-51db-0ddf-3942e598a581@solarflare.com>
Message-ID: <21804c4f-3553-cf21-0f4b-86af9548d581@grimberg.me>

Hey Bert,

> Experimental proof of concept NVMe Fabrics transport over TCP, intended
> to provide good performance over any network.
>
> Initial performance tests using both ramdisks and NVMe SSDs show latency
> and throughput broadly comparable to a RoCE transport. Further optimisation
> is needed, but we welcome input and feedback on our approach and goal of
> adding a TCP transport to the NVMe Fabrics specification.
>
> Using this requires a modified version of the nvme-cli tool, available at
> https://github.com/solarflarecommunications/nvme-cli/
>
> IPv6 support is not yet implemented, but will be added using Sagi's new
> inet_pton_with_scope.

I'd recommend that you join the fabrics 1.1 work that has started on
the NVMe TWG. I can't really provide feedback on an non-standardized
implementation, and we're obviously not going to accept it.

If you have any intentions for pursuing this, you should go through the
NVMe TWG.

Cheers,
Sagi.
