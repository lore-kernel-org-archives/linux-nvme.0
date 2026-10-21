Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78684606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UNY6OWIm;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=OCFpnxZR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/PJGvGsvZzfQUIwK+EXgT6f9qDwJ50a0sNaG7aFniiQ=; b=UNY6OWImQFPubJg9jDHDQQFkzH
	ool6Ymkm0c0RwKI7WeHt8JoPKg8m8Iv/0YmUwHmjjzwTW9xvKhrJlzy4IeRCaxkFtN4LXzkdXhRum
	0PwOLHwH7U/G6RBtPplrDHY51WgbelINiabBrAvpHKdX7VhlG1hhzbn9qn7OMboOHHtfZwFT7RLcC
	xtmwanp3gQSM1Xf/7QJXNpfgfeSX+jbP30THF1krMf7NX/m0/J/KfB3INZj5BNpp2ndblciIywMGk
	XbnbRyC4SXbI/v4wtl1YUoGAXqjkQ4VYYC1ByXBz2+h0QC2KR/kct0qxoFxDIavohljzuWMu6vl8b
	ZKUEAP2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJKl3-0000000AskT-0d48;
	Wed, 21 Oct 2026 01:04:45 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJKkz-0000000Asjq-2Wk8
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 01:04:43 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-35b2c599f43so322912eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 18:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792544681; x=1793149481; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/PJGvGsvZzfQUIwK+EXgT6f9qDwJ50a0sNaG7aFniiQ=;
        b=OCFpnxZRxBXTPcc0Lex90X1YvcNG2iTQkQU6mhp+yzPCoMkmA5WNmQ1G/hfdP0Hd0u
         C86O3b0REYlgDu5MT7BiR9ypZDDCCYj83w8HezvKEi0c/J5qy/kGfToL8TovEEkf9w+e
         v8FlNyfvBGG22f6n64w6SJZ3wNT4BqJqt2JRt4CJTggF+drRbN5VWTlOAffHqtQ+WZ3L
         5PfGRRDXZ4ecsZCN1mT4osRmOynRBywVIQ9Z1ATIrOD8FqnAdyUxteYSUO5MvQjvWcRl
         /nI7z6URA9FjJ0TTqdIAU6V8ltfAo0ScM0SHjJjYzQQLzsoYYj+GALEg1e7bCINCHvCS
         RwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544681; x=1793149481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PJGvGsvZzfQUIwK+EXgT6f9qDwJ50a0sNaG7aFniiQ=;
        b=jexNzv55VAaM+2WwL00XTSdRhmHjbvxSoibYsobdk4z6ajU2exmC/cZ3lwKXCy+X2p
         DFB2yXtOUcjS6BQd7BETCUe6ICAWydATgQ5CJDDK5ONDbSnrw5yhJvoJtZQKqM+brET3
         YpI1G0uiJMptYbk6fxQYXjWXoiYeTO6xlTyZC+fcUbXLy0AyaIsMp4gU7BBc16ncJjw9
         vBEs/GHJ1W8eS1BUkHijXPrAkDEPahqLE9Yw203xERPVP2M/1yndkJWEt/9wmrEHkEuo
         P4wvT8btv95LX2MX51780GIpcDYHCARUqA2lT2Vt2jubT6ZzrEt9er3qh1+Tf2Zv1fW7
         xOUg==
X-Forwarded-Encrypted: i=1; AKwUvByuYLu8fmfWHtHDGVNfPFlWkYoSIR+31+xuwzIlC84L9fi0rWQm51mO9kb9T2e3zVPGtqiNVbMoRwXX@lists.infradead.org
X-Gm-Message-State: AFq9FYJr2i5iC3iKLDSm82dCHdOq8KS97ICqGf27GAHMYXh2o6ZdK5Ip
	9n44qnivLriiAUJP3Ifcink2ApMR/j0OTxZ33kBDihDYz2O5+fTzKzJ/kGrkMPGGAH4=
X-Gm-Gg: AYBFou1Tfsol6Zax4drCichTOBUhHfQ0p8BOju9p1ofyv7hl23AlthOuV35oqYXpUek
	5L5NFbaWdBb5EPoh9XD5MlREPvdDS/uKmRalScTTm6VTlovNYlTcX2o0YrYcZDalMSrCy2m2IXN
	jCWUerh0xkMWaA3/0p6pZydVhN9or5scnzPI4VgFKy4+vjgBMUe7TRHB1EsYge0LjeIFjN0csxl
	GHaER7R7q00BLnaTwRE0jRvm61eDzyvVU/LQDiQcDPzGRAQfU1z50YDdq/LwB+IMhpQlOElcQVB
	GIxWsBPZkXS89z4CDFZAOhEzBJWWhqwZ+JUAM2FSUo0wy19mB4p+0IXZhnOPf2ZTJqegJVu8G+Q
	Ju2KVZfzVEMGZK0cPFAgSK0BOh1cVjmxO14N4vZMGnB1DAWamwkL9DlddLufOHZFSRKQfrd4ZHw
	iezLSgh6BYlwRP+2aA1JVAn6RNSnJ9P2TZ1isLMcTJqFpkJjcaP2Bek2zBpF21K0qdXWS5LJ427
	GrvbeOmIklCjOZy5qDZbopJODv/Joel8ih3DiZmDxFmqBlhznyuAxDDu2sj5ssUzrbvE7yMML5g
X-Received: by 2002:a05:7300:e9c5:20b0:35d:f7f4:bc1c with SMTP id 5a478bee46e88-3674d84d341mr1307105eec.6.1792544680127;
        Tue, 20 Oct 2026 18:04:40 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3674198fb21sm2176572eec.23.2026.10.20.18.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:04:39 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:04:38 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/18] nvme: Implement cross-controller reset
 completion
Message-ID: <20261021010438.GR2931-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
 <20260920182936.2317916-10-mkhalfella@purestorage.com>
 <207f5a00-7fee-4ea5-b541-38424d4766bd@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207f5a00-7fee-4ea5-b541-38424d4766bd@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_180441_830074_E7873BAE 
X-CRM114-Status: GOOD (  25.84  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-20 11:18:04 +0200, Daniel Wagner wrote:
> On Sun, Sep 20, 2026 at 11:28:07AM -0700, Mohamed Khalfella wrote:
> >  static void nvme_fw_act_work(struct work_struct *work)
> >  {
> >  	struct nvme_ctrl *ctrl = container_of(work,
> > @@ -5099,6 +5142,9 @@ static bool nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
> >  	case NVME_AER_NOTICE_DISC_CHANGED:
> >  		ctrl->aen_result = result;
> >  		break;
> > +	case NVME_AER_NOTICE_CCR_COMPLETED:
> > +		queue_work(nvme_wq, &ctrl->ccr_work);
> 
> What happens to the waiters on sctrl->ccr_list when the source
> controller enters error recovery while a CCR is pending?

You already answered it below :)

> 
> As far as I can tell, ccr_work itself is fine. The reset path cancels
> it via nvme_stop_ctrl(), and in the error recovery path the Get Log
> Page just fails once the admin queue is torn down. But the target drops
> all CCRs issued by the old association when it frees the controller,
> so the CCR completed AEN for them will never arrive. Nothing on the
> host side walks ccr_list when the controller leaves LIVE, so
> nvme_issue_wait_ccr() sleeps until min(kato, deadline - now) runs out
> before nvme_fence_ctrl() tries the next source controller. In the
> worst case that eats the whole fencing window.

If the remaining of the fencing window (deadline - now) is less than
kato then I am fine with this scenario wasting this time anyway. If we
hit the deadline then we consider fencing done anyway. If it consumes
kato from the deadline then we retry another path.

> 
> Would it make sense to fail all pending entries (set ccrs to a failure
> status and complete them under ctrl->lock) when the source controller
> goes into error recovery, so the fencing code can move on to another
> path right away?

Failing pending CCR entries that we know we are not going to complete
will help in this case. The question is where to do that. A LIVE
controller might hit an error and transition to FENCING, or manually 
reset and move to RESETTING, or deleted and go to DELETING. Do we need
to consider all these places to fail the pending CCRs?


You might have also noticed that nvme_issue_wait_ccr() calling
__nvme_submit_sync_cmd() might consume the entire fencing window if the
CCR command gets held because the source controller hits an error. This
is another area be optimized. I am inclined to leave the code as it is
today. What is being described here is an optimization that can come
later on.

