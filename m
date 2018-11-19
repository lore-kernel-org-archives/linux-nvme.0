From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Nov 2018 10:39:38 +0100
Subject: nvme: allow ANA support to be independent of native multipathing
In-Reply-To: <20181116192802.GA30057@redhat.com>
References: <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
 <20181114174746.GA18526@redhat.com>
 <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
 <20181115174605.GA19782@redhat.com> <20181116091458.GA17267@lst.de>
 <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
 <20181116094947.GA19296@lst.de>
 <bbaf4637-209c-5cfe-2749-3fcc54f7a35f@suse.de>
 <20181116101752.GA21531@lst.de> <20181116192802.GA30057@redhat.com>
Message-ID: <20181119093938.GA11757@lst.de>

On Fri, Nov 16, 2018@02:28:02PM -0500, Mike Snitzer wrote:
> You rejected the idea of allowing fine-grained control over whether
> native NVMe multipathing is enabled or not on a per-namespace basis.
> All we have is the coarse-grained nvme_core.multipath=N knob.  Now
> you're forecasting removing even that.  Please don't do that.

The whole point is that this hook was intended as a band aid for the
hypothetical pre-existing setups.  Not ever for new development.

> Please, PLEASE take v2 of this patch.. please? ;)

See the previous mail for the plan ahead.   I'm sick and tired of you
trying to sneak your new developemts back in.
