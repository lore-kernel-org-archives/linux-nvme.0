From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 18 Jan 2019 17:01:26 -0800
Subject: [PATCH v2] nvme-rdma: fix timeout handler
In-Reply-To: <CAJX3Ctit1Tquhd_g=u-EAJSgEk_g7P+7XoC_sf7LBq+xy7ztpQ@mail.gmail.com>
References: <20190108085734.9681-1-sagi@grimberg.me>
 <c5db3853-daf4-49c0-0cab-a2cb3298ed85@grimberg.me>
 <CAJX3CtgkGX_1eUU_x=v+VrUwvEA6ZwOgiPdps_-sPc5+JUFBqg@mail.gmail.com>
 <CAJX3Ctit1Tquhd_g=u-EAJSgEk_g7P+7XoC_sf7LBq+xy7ztpQ@mail.gmail.com>
Message-ID: <c5ace0a4-e4bd-7487-26fc-88b74faf97d0@grimberg.me>


> I have tested the code (backported to v4.19.9) and verified it works
> for below two scenarios I had originally reported.
> 
> * Scenario 1
> 1. issued connect nvme-cli command for nvme-rdma target with 500 namespaces
> 2. after 3 seconds while the scan process is still going, issued
> disconnect command
> 
> * Scenario 2
> 1. connected nvme-rdma target with 4 namespaces
> 2. ran IO traffic over the namespaces
> 3. changed MTU to 568 for the roce interface at the target

Thanks!
