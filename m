Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E3FC61DB9
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2026 01:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qcLcaICBn/Ust3qCyT+QAX9s51VWpBQrTS4NDoDQpJQ=; b=uJqXXlfnFy8gCdrGc7yZTQavKI
	AFr8ZbfcZLRReKdJEBaeh88Xyxd9EIv3SXVh4vwjVb1daluxvCN5nwvpgEiXI7CvqhpqdaU42H5vm
	56ufybvWu9b9Yq6t7dxeIhk6YIBbvRI5bp36htKOeG8JMZXxdmMFrdkwjqmVLzRrkeoyhFv4lRRT5
	Qny+m9+YWDlxV2U5pK4ZgsV3TSq4WO45EW9xi/TX+WBKC0p2Amdnpn+JnhXg9uB2G757tfh1Bd6sb
	pg5QlMxuB1NSiitN+mHNvMD3hxY78qeZu1090qlav0EWu3SMPVofq8XojwQYcFWYzSDfFBhtTNjSx
	F/Up6dFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x07xB-00000006aFM-3h9X;
	Sat, 29 Aug 2026 01:33:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x07xA-00000006aFG-2JrO
	for linux-nvme@lists.infradead.org;
	Sat, 29 Aug 2026 01:33:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 021304001F;
	Sat, 29 Aug 2026 01:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9773B1F000E9;
	Sat, 29 Aug 2026 01:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787967231;
	bh=qcLcaICBn/Ust3qCyT+QAX9s51VWpBQrTS4NDoDQpJQ=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=BC/btGKtX1ijynyzc9Inb7SM82UVg6ZQge8iQ45RQTu1QH5F12BEvBS9GlF8wNoWt
	 uW7FYVw2KrvE8fvQIfkzegJwdVpzC69wmYI7ruePsIoWEJddG97jMim5XIF/Vd5vT7
	 eedaDoZE7W4s7H/gsLoLV+SE+4KIKaM3WnPphjDoQyOdwzwsVcC6H5m7QRU80EKoH3
	 nJeYr2QJp6tH5rVnmvkpOrdeGFRF1JuFZpFWu0hixvkFR7uJgO56zB9VMTlMpBYeav
	 +zarnyNHD9Fn1ilVroE5P4N6t+UDjJSV2+KJHizOzaCSQMu3vOJkPrRePGLpOBIIkW
	 vzNAovJ6PDbmA==
To: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
Cc: Linmao Li <lilinmao@kylinos.cn>,  "Satish Kharat (satishkh)"
 <satishkh@cisco.com>,  "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
  "Martin K . Petersen" <martin.petersen@oracle.com>,  "James E . J .
 Bottomley" <James.Bottomley@HansenPartnership.com>,  Hannes Reinecke
 <hare@kernel.org>,  Justin Tee <justin.tee@broadcom.com>,  Naresh
 Gottumukkala <nareshgottumukkala83@gmail.com>,  Paul Ely
 <paul.ely@broadcom.com>,  "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,  "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "Gian Carlo Boffa (gcboffa)"
 <gcboffa@cisco.com>,  "Arun Easi (aeasi)" <aeasi@cisco.com>,  "Arulprabhu
 Ponnusamy (arulponn)" <arulponn@cisco.com>
Subject: Re: [PATCH 1/2] scsi: fnic: initialize the NVMe local port info
 before registering
From: "Martin K. Petersen (Oracle)" <mkp@kernel.org>
In-Reply-To: <SJ0PR11MB5896ACCB95853799B658E896C3A02@SJ0PR11MB5896.namprd11.prod.outlook.com>
	(Karan Tilak Kumar's message of "Mon, 24 Aug 2026 09:54:04 +0000")
Message-ID: <yq1o6elk8wy.fsf@mail.kernel.org>
References: <20260819114242.3598034-1-lilinmao@kylinos.cn>
	<20260819114242.3598034-2-lilinmao@kylinos.cn>
	<SJ0PR11MB5896AC03937115745995EFDFC3A12@SJ0PR11MB5896.namprd11.prod.outlook.com>
	<SJ0PR11MB58963CA2B53ABA6D1E89A0B1C3A12@SJ0PR11MB5896.namprd11.prod.outlook.com>
	<SJ0PR11MB5896ACCB95853799B658E896C3A02@SJ0PR11MB5896.namprd11.prod.outlook.com>
Date: Fri, 28 Aug 2026 21:33:50 -0400
MIME-Version: 1.0
Content-Type: text/plain
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


Karan,

> Thanks for the change. It looks good.
>
> Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
> Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>

Applied to 7.3/scsi-staging, thanks!

-- 
Martin K. Petersen

