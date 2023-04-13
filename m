Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E348FC77B6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 18:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W06UD1+iXtJudtgaAvF+EHPDAuW71kdc3rkeMdLoBUA=; b=iMta02OqHLRReCQIOAJngzqm4p
	Zp3b/cbUXyvUvU3sFkSsiJFiRkxtexgj57bg2BA179prNVVf/fWxpFAkjCfioDzvXX2p5RsYsEV3P
	oHuQO+pKY340ivix+4AI7qT8DVfUJQ0c/homT0UPDZEPiytgP311pAqmPsNLMFO6874tQvzq+ROT0
	SEz380VSCdBGRacDz4/vB8mA1JFZFqtVloB6DM/RqgKD5Zn4aFOLje0nXy9adro7cfeTwp94Lo9e6
	PQQDkAvpwzG1ggDgN2kH38njfUWYJK5dDIyybjk4T6Su+qI13EHfyScQcycEe7WqpEZkYG/+rMNlp
	x6I6Puyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pn1h0-006uaX-0B;
	Thu, 13 Apr 2023 18:29:10 +0000
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pn1gw-006uYP-1U
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 18:29:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1681410534;
	bh=jGwzJw7lP3rN+v/QJE3PZ7uZA3cqTAeu5GAX2Ol/eZo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pPwCr6Zwizp1/IBcIS46B4wxR53W8xzNoCq9q78eSRfTQaFP3DnEAVdNoOR7AUYAm
	 YA0591+re/X63z4hNO8YGCxb3KYegETQV6NepwrfwXT06e2cmix3W0jsMN02/olC5d
	 VD2oIVxEVNv1jqExdSBPtR/0FKKXEJuagOM1bzZ0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D1BB312868DC;
	Thu, 13 Apr 2023 14:28:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id AgN11Pc04sy7; Thu, 13 Apr 2023 14:28:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1681410534;
	bh=jGwzJw7lP3rN+v/QJE3PZ7uZA3cqTAeu5GAX2Ol/eZo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=pPwCr6Zwizp1/IBcIS46B4wxR53W8xzNoCq9q78eSRfTQaFP3DnEAVdNoOR7AUYAm
	 YA0591+re/X63z4hNO8YGCxb3KYegETQV6NepwrfwXT06e2cmix3W0jsMN02/olC5d
	 VD2oIVxEVNv1jqExdSBPtR/0FKKXEJuagOM1bzZ0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AFF31128666D;
	Thu, 13 Apr 2023 14:28:53 -0400 (EDT)
Message-ID: <726533b0e5f511678e4f40a768974fa818e9677f.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF] Running BOF
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org,
  linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org,  linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org,  linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org
Date: Thu, 13 Apr 2023 14:28:52 -0400
In-Reply-To: <ZALROVnC+GDXsBne@casper.infradead.org>
References: <ZALROVnC+GDXsBne@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_112906_507305_DB5B59CE 
X-CRM114-Status: GOOD (  12.64  )
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

On Sat, 2023-03-04 at 05:03 +0000, Matthew Wilcox wrote:
> Sunday May 7th is the Vancouver Marathon, and both Josef and I are
> registered.  As such, neither of us may be feeling much like joining
> or leading a run.  If anyone else is interested in participating,
> https://bmovanmarathon.ca/ offers 8km and 21.1km races as well.  If
> you just want a spot of morning exercise, I can suggest routes, but
> will probably not join you.

For those of you who fancy something more scenic and less damaging to
the knees, Mike and I were planning a hike around the chain lakes trail
by Mt Baker:

https://www.fs.usda.gov/recarea/mbs/recarea/?recid=80181

As long as there's been no recent snowfall, both the trail and the
Bagley Lakes trailhead should be accessible.  The Rangers have been
known to keep Chain Lakes closed until June, so we might have to go
along one of the other trails instead.

Mike and I are planning to drive up early on Sunday from Seattle, but
it is possible to drive from Vancouver as well if you have a car
(There's a US$5/car charge at the car park).

Regards,

James


