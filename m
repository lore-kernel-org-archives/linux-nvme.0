Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFB3CFC518
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4hRt8RZtumHYeZ62c0KfBKB9aID9kM568jUutNHXhRA=; b=b71IOQr7VfU1rn9h5gI5FhLhE+
	AMKVGFyFE0OwfUCYZInvFLrP2sXVlodRccxlR9+NZ+XGwseP5nL6zffLkslEv7cSHtL0NG9bQd5Vh
	ChdBIqILSfg+RtrZdUxUPV8slXfWIAlq1qyFGwhpj+EbVzsrAAop9Sw8qQUxnDj+FFK4qC2Ujrluh
	JJStOQFDmzfx+XaGHPs60lUuGDfPC4oCK+zpXpRAPhN9GN5j0XfKqQTeGk5I6NLZqjtJ8B1GNJouE
	TU+9d3So9fx3ZQqzT/4+Nasm4Im2TyiV6fgr/gHkuEbDifdmYdI1xdTSs3/QuyN3GTuqz9iK2OkqG
	jAsj1KUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNATJ-0000000AT1V-157V;
	Sun, 23 Nov 2025 13:49:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNATB-0000000AT14-0WnZ
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 13:49:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763905773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hRt8RZtumHYeZ62c0KfBKB9aID9kM568jUutNHXhRA=;
	b=O/JcCHdeRT0YiGxK/cBh6YaE288eHhM6nALvhDK0ImGrf+7cT5I2BzJ9uZVCqa+XCdZ1mM
	Wng5ZsxW6568+piYRxd8FMF9P2Nqbp2GgpB/uJIBTltPsGFdi/qGMisI4f7jHoNbXSUxVH
	sd1KZqM2/Fr2kb9B27Y3Msfc8UY35Dg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-JoNijKGXNZWpb1v6IBGpVw-1; Sun,
 23 Nov 2025 08:49:18 -0500
X-MC-Unique: JoNijKGXNZWpb1v6IBGpVw-1
X-Mimecast-MFC-AGG-ID: JoNijKGXNZWpb1v6IBGpVw_1763905754
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C2AF180045C;
	Sun, 23 Nov 2025 13:49:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E12D91800451;
	Sun, 23 Nov 2025 13:49:02 +0000 (UTC)
Date: Sun, 23 Nov 2025 21:48:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Stephen Zhang <starzhangzsd@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn,
	Coly Li <colyli@fnnas.com>, linux-bcache@vger.kernel.org
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO
 Chain Handling
Message-ID: <aSMQyCJrqbIromUd@fedora>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora>
 <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora>
 <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_054937_599007_6AEA3365 
X-CRM114-Status: GOOD (  16.14  )
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

On Sat, Nov 22, 2025 at 03:56:58PM +0100, Andreas Gruenbacher wrote:
> On Sat, Nov 22, 2025 at 1:07 PM Ming Lei <ming.lei@redhat.com> wrote:
> > > static void bio_chain_endio(struct bio *bio)
> > > {
> > >         bio_endio(__bio_chain_endio(bio));
> > > }
> >
> > bio_chain_endio() never gets called really, which can be thought as `flag`,
> 
> That's probably where this stops being relevant for the problem
> reported by Stephen Zhang.
> 
> > and it should have been defined as `WARN_ON_ONCE(1);` for not confusing people.
> 
> But shouldn't bio_chain_endio() still be fixed to do the right thing
> if called directly, or alternatively, just BUG()? Warning and still
> doing the wrong thing seems a bit bizarre.

IMO calling ->bi_end_io() directly shouldn't be encouraged.

The only in-tree direct call user could be bcache, so is this reported
issue triggered on bcache?

If bcache can't call bio_endio(), I think it is fine to fix
bio_chain_endio().

> 
> I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
> erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
> are at least confusing.

All looks FS bio(non-chained), so bio_chain_endio() shouldn't be involved
in erofs code base.


Thanks,
Ming


