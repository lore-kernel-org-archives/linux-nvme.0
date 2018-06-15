From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 15 Jun 2018 14:22:03 +0000
Subject: [PATCH 1/2] nvme-cli: add changed log ns support
In-Reply-To: <20180615093911.GE10928@infradead.org>
References: <20180611020508.2845-1-chaitanya.kulkarni@wdc.com>,
 <20180615093911.GE10928@infradead.org>
Message-ID: <BN6PR04MB12039D7CA1A5C19B0BD866C0867C0@BN6PR04MB1203.namprd04.prod.outlook.com>


Sure I can resend with changelog.

We want to use this log page in?blktests?after NS create/delete operations to make sure it's empty and everything is clear.

In case if that is not going to be helpful we can drop this patch, please let me.



From: Christoph Hellwig <hch@infradead.org>
Sent: Friday, June 15, 2018 2:39 AM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org; keith.busch at intel.com
Subject: Re: [PATCH 1/2] nvme-cli: add changed log ns support
? 
 
Needs a least a bit of a changelog.

What is the use case given that this is mostly something for the
driver to look into given that self-clearing nature.
    
