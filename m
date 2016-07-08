From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Fri, 8 Jul 2016 09:26:25 -0300
Subject: [PATCH v2 2/3] nvme: implement DMA_ATTR_NO_WARN
In-Reply-To: <577F5C4A.8070004@jp.fujitsu.com>
References: <1467895509-12194-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1467895509-12194-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <577F5C4A.8070004@jp.fujitsu.com>
Message-ID: <577F9BF1.8010807@linux.vnet.ibm.com>

On 07/08/2016 04:54 AM, Masayoshi Mizuma wrote:
> Here, I think the error messages should not be suppressed because
> the return value of nvme_map_data() is BLK_MQ_RQ_QUEUE_ERROR, so
> the IO returns as -EIO.

Agree; good point.  fixed in v3.

Thanks for reviewing.

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
