From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 19 Nov 2015 13:53:52 -0700
Subject: [PATCH] nvme: allow queues the chance to quiesce after freezing
 them
In-Reply-To: <1447960312-2245-1-git-send-email-jonathan.derrick@intel.com>
References: <1447960312-2245-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20151119205352.GA3422@localhost.localdomain>

> -	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
> +	if (unlikely(!nvmeq->frozen))
> +		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);

Oops... This last minute addition should have been a likely().
