From: jsmart2021@gmail.com (James Smart)
Date: Mon, 8 May 2017 09:41:46 -0700
Subject: [PATCH] nvmet_fc: Add queue create and delete callbacks in LLDD
 api
In-Reply-To: <6e4a8196-1b1e-ba2f-74a3-0b845c91d772@suse.de>
References: <20170426040409.3121-1-jsmart2021@gmail.com>
 <6e4a8196-1b1e-ba2f-74a3-0b845c91d772@suse.de>
Message-ID: <cd1cbbb8-2ea5-ac60-7685-0d5d7c2c5790@gmail.com>


> One minor addition, please add a sanity check to
> nvmet_fc_register_targetport() making sure if one registers a
> queue_create() a matching queue_delete() has to be provided as well,
> otherwise someone could theoretically build a memory leak.

ok

-- james
