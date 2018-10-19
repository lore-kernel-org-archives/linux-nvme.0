From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Oct 2018 17:38:29 -0700
Subject: [PATCH 4/4] nvme-core: support traffic based keep-alive based on
 controller support
In-Reply-To: <20181017070545.GA23049@lst.de>
References: <20180928011537.30069-1-sagi@grimberg.me>
 <20180928011537.30069-5-sagi@grimberg.me> <20181017070545.GA23049@lst.de>
Message-ID: <2e1cba3c-a391-8c45-5987-0ba5317a6a19@grimberg.me>


>> +	nvme_req(req)->ctrl->comp_seen = true;
> 
> shouldn't we only do this for controllers with keep a live support?

What is the harm setting it anyways? Would it be better to condition it
on keep alive support instead?
