From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 3 Mar 2016 00:47:29 -0800
Subject: Tested LBA size ?
In-Reply-To: <56D723B9.6030004@ip-maker.com>
References: <56D723B9.6030004@ip-maker.com>
Message-ID: <20160303084729.GA1280@infradead.org>

Hi Olivier,

Linux in general does not support LBA sizes bigger than the VM page
size.  
