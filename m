From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Jun 2014 15:28:30 -0600 (MDT)
Subject: [PATCHv3] NVMe: Async event request
In-Reply-To: <4153505278C0BF4DABE3DF3D82533FE23026BC6E@NTXBOIMBX05.micron.com>
References: <1403121537-28806-1-git-send-email-keith.busch@intel.com>
 <4153505278C0BF4DABE3DF3D82533FE23026BC6E@NTXBOIMBX05.micron.com>
Message-ID: <alpine.LRH.2.03.1406231524580.4699@AMR>

On Mon, 23 Jun 2014, Winson Yung (wyung) wrote:
> Hi Keith, are you suggesting user to scan the system logs to find out all the
> async events. I found your following patch using read/poll get async events
> is much preferred:
>
> http://lists.infradead.org/pipermail/linux-nvme/2013-August/000350.html

Yes, I provided my reasoning in v1 of this PATCH. Basically we can view
this problem in two separate parts: (1) driver ability to submit async
event requests, and (2) presenting the responses to the user. This patch
mainly handles the former.
