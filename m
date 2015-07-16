From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 16 Jul 2015 05:46:41 -0700
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs
In-Reply-To: <55A7A250.5050307@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
 <20150609074643.GA5707@infradead.org>
 <55787DDE.7020801@bjorling.me>
 <20150611102935.GA4419@infradead.org>
 <557C5787.3000608@bjorling.me>
 <20150617135905.GA17119@infradead.org>
 <55A7A250.5050307@bjorling.me>
Message-ID: <20150716124641.GA11298@infradead.org>

Hi Matias,

the underlying lighnvm driver (nvme or NULL) shouldn't register
a gendisk - the only gendisk you'll need is that for the block
device that sits on top of lightnvm.
