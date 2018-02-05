From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 5 Feb 2018 10:30:27 +0800
Subject: [PATCH 1/6] nvme-pci: move clearing host mem behind stopping
 queues
In-Reply-To: <20180202184605.GJ24417@localhost.localdomain>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-2-git-send-email-jianchao.w.wang@oracle.com>
 <20180202184605.GJ24417@localhost.localdomain>
Message-ID: <848639df-1a65-35fe-1c7d-d79cfe4ec581@oracle.com>

Hi Keith

Thanks for your kindly response and directive.

On 02/03/2018 02:46 AM, Keith Busch wrote:
> This one makes sense, though I would alter the change log to something
> like:
> 
>   This patch quiecses new IO prior to disabling device HMB access.
>   A controller using HMB may be relying on it to efficiently complete
>   IO commands
Yes, I will change it next version.

Sincerely
Jianchao
