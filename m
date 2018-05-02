From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 2 May 2018 09:27:57 -0600
Subject: [PATCH] nvme-cli: allow block device for delete-ns
In-Reply-To: <20180502115751.xtvf5pehho3g64yj@linux-x5ow.site>
References: <20180502044840.28801-1-chaitanya.kulkarni@wdc.com>
 <20180502115751.xtvf5pehho3g64yj@linux-x5ow.site>
Message-ID: <20180502152757.GF5938@localhost.localdomain>

Thanks, applied with a minor fixup to check for nsid <= 0 instead of
just == 0.
