Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C93C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 07:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:From:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=05cGtA6yxrBEXr8TsKfNblRw+Bdby9YhP92PsT290U4=; b=X2k9gRa68JxcApVuorEpZ/x2sy
	HNXwC8qvC/LuP3SzKrq7Vp77FpKxrfWzyDwIPRZEdDkwwb3IfHggMvWetRGX7K7I6MNLCpcHj4uOZ
	utTxVehXyASprMD2r9+RR9l/J0L5GFkqK0w8q9wejWHGKUU+Sdhst52fUJO97IMtS6tBn5RzBfJzr
	pWnrXAISZZ6HeRl9CaJltJK94j0AdTpK5APytDqcngJxTwf5REVEkMRFz2lVgag+PtvOTKRc/o7BR
	jWqEh9bQoklwtRZOFFksjITOc7F7O/erbjm3yOpKFiHOVkYAoK9I/gEZRoiSoZ9/3KS7y3YysSS8D
	my+evH1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbzjR-004LB1-3j; Wed, 06 Apr 2022 07:05:33 +0000
Received: from mail1.bemta34.messagelabs.com ([195.245.231.4])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbzjE-004L5X-H5; Wed, 06 Apr 2022 07:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1649228714; i=@fujitsu.com;
 bh=05cGtA6yxrBEXr8TsKfNblRw+Bdby9YhP92PsT290U4=;
 h=Date:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:
 Content-Type:In-Reply-To:From;
 b=BJDFFQHg7gw8WYACPIsS5IO7QZ2Et0/snRy0O1P7sPcx3klPBjnAcFB0x5vQmkc7B
 wdj7sgZsarcq07EkkN9Uk7cWaXRM4BHIkDNaIuDnoDW/xdWPN+yfeRQ0VLd0GPd0XX
 YqbordNSTrdttI2gAjHO+G0BfdXM58RE64W8BbUe7mviFWROX5XjUVwj2GTsNCRtCK
 2WJ4V8hKwe8nmUuYA+n39zIapfnu0J3NGApl7UCEEBLyvU7tS2BrmjwMlFpa9b2hDX
 gUaY7GvBudukN14SBUkBadO1YF+sMHYk2wGdlkRTCLILZZ+pMjV2no6kK1JlP7i/NG
 hrGSl+X1ARJQg==
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSf1CTdRzH+T4bzx5hDz38iq9L8ljCH3ibDDW
 +ilh6lk8nFJfJJVfZgyy2GsjteThnXAdKKIcRKiTHVFDHrwFhB6OIOQ60BDwhGM6BFxWyGU4R
 kwqMX+1p54/+e3/u9fq8P/98CEFAPS4hlDpOqc1gNFLcR7h5E8HI6mITUqJcB19GDaPFOHowc
 gJDvQ3jOLLcP+WNxmx1QmRs+BFDg3/kY+jKtzcwZLm5GlnH60SovOJnHFnPb0cXLb1C9Evjkj
 f6YakYIPOhGhGaL1uHKmucInSksh2gY+fyBOiovQ1HRfXxqH2+TYTmnF9jyDjeiqH2e/0ilF8
 9iaHavgoczZhKsFdD6aG+LLr54QkR3VKVQ3/+22GcLhmuBfRESzmgzWenMfryg+tC2jySi9MD
 Nfdw2vZ3noCe6rDh9HTzi4lksrc6I2Wf7kNv1dRoF5Y56KNrt1zGc8E8UQiWEQGUCcBbV94sB
 D7ubASwqMMkKASEe8iChp/EvCOkVkFLpRnwOYiSQqerD/C+gGoiYZfTIeL9QCoZLt6O5x2Sio
 Z/3jJgnv6X4BnbAs77JDVLwuq2CW8PyIZHf50Uehb8YW+5478soCLh8OIdjO8UUC/A2kWCj8u
 oJJh/XMobkFoB54wzOJ+D3fVNhl7AKzi1BrqKGI8SAW39zYJjIFD/TL/+mX790/6zQFAPNqZo
 1WkqLp1Ra2SKqCiZQrFetjZGptggZz6VMXJllmy/kuVk0XJmPytXsqycPZC+V5Mqz1ByzcD9Q
 qlseGAbKDA+kl8CywlMGkz6KhJSAvxS9qUeUDGsao82S6NkL4EVBCGFZBxyM3+tMk2p+0itcT
 /iYwwJsTSIrNroxiSbyaSz6jQPugrCJCHkyAY3oHigysp4svb4ha0gVBJIAi8vrwBxplKbrub
 +z10ghADSQHIHXy9WZ3BP2l3uw5j78P1rb/CHOeYpkuRiOVWl7x8SfveXV2mR5OTzV3PqoheN
 8ht3LNyuk9zUZwMLSQn2nG7ZBY2j9fXj4/Xh6J+Y0PeSaktax4Y6d4cFOZ7z//LgrtqvDm/2t
 W9dWnvb3L/tiNrwdkfbzTDCd94gjg5/95FjbO+gZtI+y5ozcZk43XrBOln9+2vFBZvW567Z9r
 1f6qzuA8KkHzrTOXG3xfXJW3si49dl55zK18VVrPzm9FJB8kxZ07XEPMeA3frKF82dFysL5hq
 Dd6++a1ie0POwZ2DnaGwMN709Qp+4yh63My4WdkU4sod7ulc6TeLr3X51WxpLqKCwyK0maam1
 qj6pbOGdEGdhiVl3Pu3jc0Nb9JxUyKoYRaRAyzL/Akr/LJA9BAAA
X-Env-Sender: Alan.Robinson@fujitsu.com
X-Msg-Ref: server-8.tower-548.messagelabs.com!1649228712!85085!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31866 invoked from network); 6 Apr 2022 07:05:12 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-8.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 6 Apr 2022 07:05:12 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 3681F100190;
 Wed,  6 Apr 2022 08:05:12 +0100 (BST)
Received: from nera.osd.abg.fsc.net (unknown [172.17.20.8])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with SMTP id 07836100181;
 Wed,  6 Apr 2022 08:05:10 +0100 (BST)
Received: by nera.osd.abg.fsc.net (Postfix, from userid 5004)
 id B86E417478B; Wed,  6 Apr 2022 09:04:46 +0200 (CEST)
Date: Wed, 6 Apr 2022 09:04:46 +0200
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, 
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, 
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 15/27] block: use bdev_alignment_offset in
 part_alignment_offset_show
Message-ID: <20220406070446.GA1722@ts.fujitsu.com>
Mail-Followup-To: Alan.Robinson@fujitsu.com, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, 
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, 
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20220406060516.409838-1-hch@lst.de>
 <0b7ae3df301c4fdd8d37f773d8d1eb93@FR3P281MB0843.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7ae3df301c4fdd8d37f773d8d1eb93@FR3P281MB0843.DEUP281.PROD.OUTLOOK.COM>
X-sent-by-me: robin@sanpedro
User-Agent: Mutt/1.9.3 (2018-01-21)
From: Alan.Robinson@fujitsu.com (Alan Robinson)
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_000520_768402_66BCCC26 
X-CRM114-Status: GOOD (  22.47  )
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
Reply-To: Alan.Robinson@fujitsu.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph,

On Wed, Apr 06, 2022 at 06:05:04AM +0000, Christoph Hellwig wrote:
> From: Christoph Hellwig <hch@lst.de>
> Subject: [PATCH 15/27] block: use bdev_alignment_offset in
>  part_alignment_offset_show
> 
> Replace the open coded offset calculation with the proper helper.
> This is an ABI change in that the -1 for a misaligned partition is
> properly propagated, which can be considered a bug fix and maches

s/maches/matches/

> what is done on the whole device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/partitions/core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 2ef8dfa1e5c85..240b3fff521e4 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -200,11 +200,7 @@ static ssize_t part_ro_show(struct device *dev,
>  static ssize_t part_alignment_offset_show(struct device *dev,
>  					  struct device_attribute *attr, char *buf)
>  {
> -	struct block_device *bdev = dev_to_bdev(dev);
> -
> -	return sprintf(buf, "%u\n",
> -		queue_limit_alignment_offset(&bdev_get_queue(bdev)->limits,
> -				bdev->bd_start_sect));
> +	return sprintf(buf, "%u\n", bdev_alignment_offset(dev_to_bdev(dev)));

Should this now be %d instead of %u, there are one or two examples of
both in the rest of the patch series.

Alan


