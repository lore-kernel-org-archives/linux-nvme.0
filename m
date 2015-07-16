From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Thu, 16 Jul 2015 15:06:59 +0200
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs
In-Reply-To: <20150716124641.GA11298@infradead.org>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <20150609074643.GA5707@infradead.org> <55787DDE.7020801@bjorling.me>
 <20150611102935.GA4419@infradead.org> <557C5787.3000608@bjorling.me>
 <20150617135905.GA17119@infradead.org> <55A7A250.5050307@bjorling.me>
 <20150716124641.GA11298@infradead.org>
Message-ID: <55A7AC73.9070309@bjorling.me>

On 07/16/2015 02:46 PM, Christoph Hellwig wrote:
> Hi Matias,
>
> the underlying lighnvm driver (nvme or NULL) shouldn't register
> a gendisk - the only gendisk you'll need is that for the block
> device that sits on top of lightnvm.
>

That could work as well. I'll refactor the nvme/null drivers to allow 
that instead. Thanks
