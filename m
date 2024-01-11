Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262C0C47077
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jan 2024 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yzRCvlsTRGnFzhLrpDej9blmMSAiS/7ddLOHv3Y+1vE=; b=OPDgA8/+Jk1/3JGCKipHG9tJ2s
	9fPdTfeqwnSdL3AVz+lZa1dqOfoNnaKHcupmcZU9E+sJ/NfCeMAZtl9sYJe4krlIz70EP3vQ1k/nr
	ONW6TsHZlymbUJPf0YJpUaU/K/aIIHxqyUK3FV5QU6w4dgFXuT7sucIbj7xzaw7PIDKD9c2A2EN5o
	y+XgcE59zOcJBs5To6ErLHzdtQbj71Vv+CEHr2oWHQ1FDdw+jpMuhSoo8X9Oawyx4W/xQd46Nq3x5
	OdI8gAHmxmvAA/aGG6Wb2QKj6Zxs7eHb8jeRokytx1bYnqjxzon4QPgx3ElLPJ9SrnrbXe5H6GIA1
	f1/CU+VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNwJa-000JfS-1R;
	Thu, 11 Jan 2024 14:45:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNwJX-000JeP-2E
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jan 2024 14:45:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 783DE68CFE; Thu, 11 Jan 2024 15:45:38 +0100 (CET)
Date: Thu, 11 Jan 2024 15:45:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, axboe@kernel.dk,
	kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ming.lei@redhat.com, bvanassche@acm.org,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <20240111144537.GA9295@lst.de>
References: <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com> <20231219151759.GA4468@lst.de> <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com> <20231221065031.GA25778@lst.de> <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com> <ZZ3Q4GPrKYo91NQ0@dread.disaster.area> <20240110091929.GA31003@lst.de> <20240111014056.GL722975@frogsfrogsfrogs> <20240111050257.GA4457@lst.de> <d5db2291-36b4-4b22-89f2-1d9e7d30f0f1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5db2291-36b4-4b22-89f2-1d9e7d30f0f1@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_064547_889110_5089793A 
X-CRM114-Status: GOOD (  17.77  )
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

On Thu, Jan 11, 2024 at 09:55:36AM +0000, John Garry wrote:
> On 11/01/2024 05:02, Christoph Hellwig wrote:
>> On Wed, Jan 10, 2024 at 05:40:56PM -0800, Darrick J. Wong wrote:
>>> struct statx statx;
>>> struct fsxattr fsxattr;
>>> int fd = open('/foofile', O_RDWR | O_DIRECT);
>
> I'm assuming O_CREAT also.

Yes.

>> I think this still needs a check if the fs needs alignment for
>> atomic writes at all. i.e.
>>
>> struct statx statx;
>> struct fsxattr fsxattr;
>> int fd = open('/foofile', O_RDWR | O_DIRECT);
>>
>> ioctl(fd, FS_IOC_GETXATTR, &fsxattr);
>> statx(fd, "", AT_EMPTY_PATH, STATX_ALL | STATX_WRITE_ATOMIC, &statx);
>> if (statx.stx_atomic_write_unit_max < 16384) {
>> 	bailout();
>> }
>
> How could this value be >= 16384 initially? Would it be from pre-configured 
> FS alignment, like XFS RT extsize? Or is this from some special CoW-based 
> atomic write support? Or FS block size of 16384?

Sorry, this check should not be here at all, we should only check it
later.

> Incidentally, for consistency only setting FS_XFLAG_WRITE_ATOMIC will lead 
> to FMODE_CAN_ATOMIC_WRITE being set. So until FS_XFLAG_WRITE_ATOMIC is set 
> would it make sense to have statx return 0 for STATX_WRITE_ATOMIC. 

True.  We might need to report the limits even without that, though.


