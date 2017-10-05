From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 Oct 2017 01:00:40 -0700
Subject: [PATCH v2 4/7] nvme_fc: add dev_loss_tmo to controller
In-Reply-To: <20170927045046.22238-5-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-5-jsmart2021@gmail.com>
Message-ID: <20171005080040.GB5063@infradead.org>

Can you please add the dev_loss_tmo to the generic nvme_ctrl and build
the infrastructure in common code?

Then as a next step we can look into inferring it from the remote port
for FC.
