From: james.smart@broadcom.com (James Smart)
Date: Sat, 20 Jul 2019 11:33:06 -0700
Subject: [PATCH v2 07/10] nvme-cli: Add routine to search for controller
 with specific attributes
In-Reply-To: <20190720082504.GG22395@minwoo-desktop>
References: <20190719225305.11397-1-jsmart2021@gmail.com>
 <20190719225305.11397-8-jsmart2021@gmail.com>
 <20190720082504.GG22395@minwoo-desktop>
Message-ID: <ca511e18-6141-2bbb-a5c6-ce6ad802c10a@broadcom.com>

On 7/20/2019 1:25 AM, Minwoo Im wrote:
> James,
> It might be too late to discuss about this argument, but did you decided
> to have (struct connect_args) as a parameter for this function?
>
> Sorry for not giving any thoughts on the following mail[1], but I would
> prefer not introducing a new data structure for this because it's just a
> bypass argument from a perspective of find_ctrl_with_connetargs().  But
> If you think it's okay to go with, then I'm fine with that too.
>
> [1] http://lists.infradead.org/pipermail/linux-nvme/2019-July/025646.html
>
> Thanks!

It's never too late.? I talked briefly with Sagi before reposting. He 
had a request for a future item that looked like it may be able to use 
the structure.? So I left it as is.

-- james
