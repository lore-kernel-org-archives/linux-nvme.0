From: hch@lst.de (Christoph Hellwig)
Date: Wed, 17 Oct 2018 09:05:45 +0200
Subject: [PATCH 4/4] nvme-core: support traffic based keep-alive based
 on controller support
In-Reply-To: <20180928011537.30069-5-sagi@grimberg.me>
References: <20180928011537.30069-1-sagi@grimberg.me>
 <20180928011537.30069-5-sagi@grimberg.me>
Message-ID: <20181017070545.GA23049@lst.de>

> +	nvme_req(req)->ctrl->comp_seen = true;

shouldn't we only do this for controllers with keep a live support?
