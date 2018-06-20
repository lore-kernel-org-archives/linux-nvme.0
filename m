From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 20 Jun 2018 12:33:24 +0300
Subject: [PATCH v2 1/2] nvmet: reset keep alive timer in controller enable
In-Reply-To: <20180620090611.GA4188@lst.de>
References: <20180619124534.26736-1-sagi@grimberg.me>
 <20180620090611.GA4188@lst.de>
Message-ID: <3941d283-0d98-b69c-3d5b-c544cc52aa50@mellanox.com>



On 6/20/2018 12:06 PM, Christoph Hellwig wrote:
> I've applied both patches to nvme-4.18.


the second one is not complete for error flows (I've mentioned it 
yesterday).  We should re-think about my V1 suggestion to start/stop 
keep-alive during configure/destroy admin queue, or find another 
solution. I find it strange to have exported nvme_stop_keep_alive and 
non exported nvme_start_keep_alive.


> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C47a667b338604182f4dd08d5d68be4cf%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C1%7C636650818702308730&sdata=m7GH93WOn%2F0CZhx0YN6XNjWdqlOh4V16Kaz5sl1JpOk%3D&reserved=0
> 
