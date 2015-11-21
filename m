From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 21 Nov 2015 03:12:10 -0800
Subject: nvme lightnvm comments
In-Reply-To: <20151120105022.GA22131@infradead.org>
References: <20151120105022.GA22131@infradead.org>
Message-ID: <20151121111210.GA19360@infradead.org>

Btw, another one: it seems like LightNVM devices still claim to
use the NVM I/O set per CAP and CC, which seems a little odd.
