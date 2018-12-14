From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 14 Dec 2018 10:43:20 -0800
Subject: [PATCH] nvme-pci: only set nr_maps to 2 if poll queues are
 supported
In-Reply-To: <20181214162019.14847-1-hch@lst.de>
References: <20181214162019.14847-1-hch@lst.de>
Message-ID: <9d2fa9e4-927e-655b-5db3-32d8f0a17db7@grimberg.me>


> The block layer now enables polling support on a queue if nr_maps
> includes the poll map, so we should only set that if we actually
> support poll queues.
> 
> Fixes:  6544d229bf ("block: enable polling by default if a poll map is initalized")

What does it fix? is there a bug when setting 3 queue maps?
