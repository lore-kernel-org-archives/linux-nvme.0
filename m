From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Mar 2018 07:53:22 -0800
Subject: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
In-Reply-To: <6B6A0FD9-14F5-4AF2-A74A-DAA562C34AB9@raithlin.com>
References: <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301234930.GG14799@localhost.localdomain>
 <6B6A0FD9-14F5-4AF2-A74A-DAA562C34AB9@raithlin.com>
Message-ID: <20180302155322.GA5934@infradead.org>

On Thu, Mar 01, 2018@11:53:16PM +0000, Stephen  Bates wrote:
> > There's a meaningful difference between writing to an NVMe CMB vs PMR
> 
> When the PMR spec becomes public we can discuss how best to integrate it into the P2P framework (if at all) ;-).

http://nvmexpress.org/wp-content/uploads/NVM-Express-1.3-Ratified-TPs.zip
