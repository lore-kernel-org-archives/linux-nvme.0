From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 17:11:43 -0800
Subject: [PATCH 10/13] nvme-mpath: remove I/O polling support
In-Reply-To: <20181202164628.1116-11-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-11-hch@lst.de>
Message-ID: <f62ed781-28cd-dae0-f3aa-544d75cdc4fc@grimberg.me>

> If it really becomes an issue we
> should rework the nvme code to also skip the multipath code for any
> private namespace, even if that could mean some trouble when rescanning.
>

This requires some explanation? skip the multipath code how?

Other than that,
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
