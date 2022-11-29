Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FDEC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 08:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ll8adlbd4mpMCn/XqEsw7DfOyBPlh9xblMPx9JQ88lA=; b=xGzNAxPnK70jJ7MYmUFjRfV2qI
	Brh7Mxht6WQIcTm1lDlFQDwaXpiUpDfyg9dcnYv3sZKX88utRb0X+nf8DsnoGVkz04Bjo8VnM2JkN
	AnLuUT0or0VDiQcnnIkabmyXi8h6UYxsFqQfE5MJAIs35qOMPYdgQPR3aUG5eB9YdLv+wictfic0T
	UMtBt0s0t0YRkx6e+m0sR49//3hD/01XpcaHoETjNy6Pkl5h58in2epUxEyytaoiet7TFQQOBvQn0
	MWP+dvvK7eTLDtIoFoUpA56ABYk2geYQ/Q1sQf3F6OR4H+OpXIga6PdUp/csS2eXmRSnEoCf3Esir
	PTIVE3QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwCy-007TCI-2U; Tue, 29 Nov 2022 08:43:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwCv-007T9y-4R
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 08:43:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6238D68AFE; Tue, 29 Nov 2022 09:43:10 +0100 (CET)
Date: Tue, 29 Nov 2022 09:43:10 +0100
From: "hch@lst.de" <hch@lst.de>
To: "Rao, Lei" <lei.rao@intel.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: clear the prp2 field of the nvme command.
Message-ID: <20221129084310.GB25609@lst.de>
References: <20221129014711.91305-1-lei.rao@intel.com> <15de4902-03e7-0d2c-4b4c-45d713d0f1fd@nvidia.com> <4cee0097-4f08-1990-112f-6e39229f59ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cee0097-4f08-1990-112f-6e39229f59ef@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_004313_336468_4CEA1FFB 
X-CRM114-Status: GOOD (  13.38  )
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

On Tue, Nov 29, 2022 at 12:50:57PM +0800, Rao, Lei wrote:
> stricter checks, and if prp2 is not used but has a value, some warnings will be
> printed. According to the NVMe spec, it seems to write a reserved field produces
> an undefined result, so maybe clearing it is better.

NVMe is a little weird about reserved fields settable by the host.
I don't think your controllers warnings are correct, but given that
the cost of clearing is very low I think we should clear it in Linux.
Please resend a patch with the clearing in the right place as suggested
in my previous mail.

