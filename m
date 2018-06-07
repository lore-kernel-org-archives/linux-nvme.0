From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 14:09:41 +0200
Subject: [PATCH 3/4] nvme: ANA transition timeout handling
In-Reply-To: <20180607073556.39050-4-hare@suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-4-hare@suse.de>
Message-ID: <20180607120941.GC11938@lst.de>

> +	timer_setup(&ns->anatt_timer, nvme_anatt_timedout, 0);

ANATT is per-group, so having a timer in the namespace is wrong.
