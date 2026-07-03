Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764D0C43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YiywiaC4VnDfvSGNTu0J2NjCWbP9RvWAv+silBhR3io=; b=09rcfYF7UDJfGaObJoSp6Wf6iQ
	N4cJ61/o3ozb3sas9VGlwzn4tvFSovD8vtnVJK0KYSO6XYdvuyiRFu2TsHaF5LptH5w2rIAemUwpZ
	gMIJSVWG86NlQqSnEiUFG9KqywnyE4Wur7QHV4wOVICdhljMXbKAJjspnw15d+0fowhMgK/nyIkFB
	Wcov0cPJ1kIeQY3AB8BaZK1nYZmQ0Cr8k9aVx6g+Jw6lZb+LKyJaDz3VUWpGZX5ypyAH/quK6Gkko
	K0Cvb8ScozEqupkSis+n5LDRCJs/odq5+PRAIZaF9NTMGeEavFgfyatQ718c4D3G8zEVCCktX+IA0
	G/AbJSsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg21P-00000008WrG-0nc2;
	Sat, 04 Jul 2026 15:11:11 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfWvf-000000067L0-1TRb
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 05:59:12 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id EAEDD20B716C; Thu,  2 Jul 2026 22:59:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAEDD20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783058347;
	bh=YiywiaC4VnDfvSGNTu0J2NjCWbP9RvWAv+silBhR3io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nK7H1bsTOvgTzOeO8031IWUUbWeDCb8M0VGxhZhfYl8l9O0m9T3ckRukJcIUBWmxy
	 0i2ZRCut3ROW/57Ckt/bRf4ZENFlE1EtJSj6JUTLvObYyintLzJbwLMFZQqZz/40l9
	 czKWP2W6o19LfU9ENtVCjFPn2ZhljOJtjNn/MafA=
Date: Thu, 2 Jul 2026 22:59:07 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	mkalderon@marvell.com, zyjzyj2000@gmail.com, sagi@grimberg.me,
	mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
	bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, markzhang@nvidia.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v8] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <akdPqz9L8/IPLqml@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260619203107.606359-1-ernis@linux.microsoft.com>
 <akX/P/0TiSQ38YdS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <akYocsiHWdH8Tncq@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akYocsiHWdH8Tncq@ashevche-desk.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_225911_417787_2D139153 
X-CRM114-Status: GOOD (  21.34  )
X-Mailman-Approved-At: Sat, 04 Jul 2026 08:11:05 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 02, 2026 at 11:59:30AM +0300, Andy Shevchenko wrote:
> On Wed, Jul 01, 2026 at 11:03:43PM -0700, Erni Sri Satya Vennela wrote:
> > On Fri, Jun 19, 2026 at 01:30:39PM -0700, Erni Sri Satya Vennela wrote:
> > > The capability counter fields in struct ib_device_attr are declared
> > > as signed int, but these values are inherently non-negative. Drivers
> > > maintain their cached caps as u32 and assign them directly into these
> > > int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> > > negative value visible to the IB core.
> > > 
> > > Change the signed int capability fields to u32 to match the
> > > underlying nature of the data. Also update consumers across the IB
> > > core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> > > are not forced back through signed int or u8 via min()/min_t() or
> > > narrowing local variables.
> > 
> > Just a friendly follow-up on this patch. The Sashiko review mentioned a
> > low-priority item, and I'd appreciate any guidance on whether the change
> > is needed.
> 
> As I read this it needs to be fixed, the problem is that there is
> a potential of a weird case (not sure they are IRL) when somebody can use
> INT_MIN (in representation of signed number) to actually mean 0x80000000
> size.
> 
> > https://sashiko.dev/#/patchset/20260619203107.606359-1-ernis%40linux.microsoft.com
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
Thankyou for the confirmation, Andy.
I'll add this change in the next version.

- Vennela

