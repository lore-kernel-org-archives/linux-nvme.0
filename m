Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7357C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jan 2022 22:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	To:From:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4oMsGed/nkO+6DXAz4ivqn+OCGnlOcoXX0g7fA1enlY=; b=ocv6JfiqenueYd
	wFUeANL6HgRvQcHvE1A8OWTxaYyU8s5+dkWEoTkMvlhet659pBOzu/aTmvTlQra0YmoVCB/NiD7XA
	Gm0g2OUPHQ7g+hIm87cibhdIINv5k8bSjmAC/5mprpgU0NPdQlmkas4UGjhjL0iOqi9HIYQftcIBs
	/r+wAeqRzEkVB3FioaS7o8rB0Mx4bYBzjO43DrYp5mbrP9oNCj7MXk1d3aI3g1CL5H/gKNYiyU/DN
	98dobg//HE6eynTtki9mE5RUUCrPZyaOB/QV8M4YjSAd1oJDR6LnFGMCXbCe2cIk3sRA35uxVIUPb
	S58toltL75jXdK3wvLBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n4ryo-00CzaU-Nd; Tue, 04 Jan 2022 22:08:30 +0000
Received: from slot0.jllresort.com ([62.197.136.5])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4ryl-00CzYN-T6
 for linux-nvme@lists.infradead.org; Tue, 04 Jan 2022 22:08:29 +0000
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=jllresort.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 i=ele.mon@jllresort.com; bh=pzqwCTSn81Wrxsgi1teEtVVWBeQ=;
 b=p/mj50VKVSrq+Mh/YvVF0BDvM6yC7QkQf0WkwUWQCI6PhBbIBmrV3VAXReAl1W1Ni7IIr9ZTRBR+
 GeCRQkaNqZSfzu5qfHO5+mWMT9oXCaf89uHxqmafoEK1lOZpmjEUQcdXdcLhPAMShEDWKxQleuY+
 42HuzZ2UcmaH1Yh5r84+OzZxL4k3m8cPzkG88BEASUr78eU0vwn5ApdcwxrRXq6LHFXqIClZFdRf
 ITWk30dqDT3btKscDglz6h6IpgF2sr6k3yyRQSB8JeTPjnpwQVn4RMSZZDAQEqIdaIMAoo02c3L3
 2KfOpggja5f5fqEWUsNhonXzMWdckmI0vnRtOA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=jllresort.com;
 b=l7YvWhALvFhexBMysBjP4/ZARnL0esmSYFc9d1wpzZeo/7Hjs1/C3thadDvtbnZBu9jr8VLatLKx
 MZoVal9CycSZUobJ5R+ZG7ms4DMKQ7/QcKPt/aXWi84t6vlhHkjjzEVi4YNdqTjeikE8FbnjIPEv
 TryDCTJN8bpAq7qA0qzT6OB5gLiHWsFEVuvx9kFwCgS+3mtv4v06sXPn2Fjji29IPcbFjcbz5Uum
 h3CFF5s/5dSxk+uq9caSfd4a1meSVGpB6a6wv28U4Ya2ZIWx4rCeNOCmbZnpkEqpHsw2ZtMXFi/D
 cSUN7ceuvTrK5BoXCkFDPmqCcL31wGSVPzFdVw==;
From: ele.mon@jllresort.com
To: linux-nvme@lists.infradead.org
Subject: Attention:
Date: 4 Jan 2022 23:08:21 +0100
Message-ID: <20220104230821.FF0E841266FACFB8@jllresort.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220104_140828_136054_FAF2A668 
X-CRM114-Status: UNSURE (   0.93  )
X-CRM114-Notice: Please train this message.
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
Reply-To: ayvazmustafa231@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Greetings to you linux-nvme,

I was wondering if you got my previous email? I have been trying=20
to reach you by email linux-nvme@lists.infradead.org, kindly get=20
back to me swiftly, it is very important.

Thanks
Mustafa Ayvaz
Email: mustafa.ayvaz@ayvazburosu.com

