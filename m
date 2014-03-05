From: keith.busch@intel.com (Keith Busch)
Date: Wed, 5 Mar 2014 13:45:24 -0700 (MST)
Subject: Expected performance level of nvme driver v0.8 (Ubuntu
 13.10/3.11.0-12-generic)
In-Reply-To: <53177C9B.8080606@aeoncomputing.com>
References: <53177C9B.8080606@aeoncomputing.com>
Message-ID: <alpine.LRH.2.03.1403051242070.2885@AMR>

On Wed, 5 Mar 2014, Jeff Johnson wrote:
> Greetings,
>
> I am doing some testing and benchmarking with the v0.8 nvme driver in
> Ubuntu 13.10/3.11.0-12-generic. With a PCIe Gen3 nvme compliant device I
> am seeing sequential (single thread) write and read numbers in the
> 900MB/sec range. Based on the device I was expecting higher numbers. Is
> this an expected level of performance for this version of the driver?

Hi Jeff,
The driver is capable of performing beyond that, but it wouldn't be
possible to say what factors contribute to the performance you're seeing
based on this information.

> Thanks,
>
> --Jeff
