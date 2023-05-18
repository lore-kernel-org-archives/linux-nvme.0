Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F9FC7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 08:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IfqQW79nVX/qUpmHcJiWDpV9BQnOf/s+Zcq9ON74QJY=; b=Ol+rFtPcmlEbEHM4lEV7bS7i07
	YFToWi+5hNcO9C4DdeQMZeHXMWlmsjDi9Xd0NIrw4AYx4lYtusi5amqhQbNfVu8HD/TpX3vTNu2y4
	B5N5U55V0QMbgYf/rH/MGZ/PN5OvxgsZeRvWJl1TJv+/zPrUA7MXdN+NoHbQyxXxmpHI0W1F8GbQx
	wTUX4mPio7iMVSclq+1G5XRav+hQ6Wf/9RzdnTxLUk1CBMv8wvws73nJG1i0piitJkYqApBZOz+jT
	U0GOcpJM7X0Ds7NKykhh1HKVjw0t1T1Qdt23XAaVLo0io3+oztZ7DLsOHeVKt8+YaTOixW7HHcqez
	bM09+UZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzYjf-00CJ4L-0J;
	Thu, 18 May 2023 08:11:43 +0000
Received: from mail.mahavavy.com ([92.222.170.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzYjb-00CJ38-2X
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 08:11:41 +0000
Received: by mail.mahavavy.com (Postfix, from userid 1002)
	id CB2CE234D5; Thu, 18 May 2023 08:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mahavavy.com; s=mail;
	t=1684397485; bh=IfqQW79nVX/qUpmHcJiWDpV9BQnOf/s+Zcq9ON74QJY=;
	h=Date:From:To:Subject:From;
	b=R7oTk7+HcYmYIeRXFGpm8ZF6i9ao/Frzw6ZXRV4fSuA4/80+BOImNQdP2QGU12OaW
	 KI9+sEVJ3mxsOHmU5dlnmV3UitVdH36Baoos33ReLug9RC/pL6lpI1ObEXgS6AL4Mj
	 ffYQT+4jvbfq3ulJqxRtgvHYMFbh5+KJuBPdUJgIUt5Aro8HNN/twjzGxT5FZwU9vV
	 I159GzWvRJbebWY1C9L+e/XXX5GaEz4cvlQXX78dc+8AoFxc3DK+WPh29NgTNPTvX2
	 xdZuaHauhSRtFm4JynwmebRlyhFLJYoQIOrXKWIgoNXlxD6/lvYSdP2dE8roFubYFb
	 XaozpsgPXtvyQ==
Received: by mail.mahavavy.com for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 08:11:09 GMT
Message-ID: <20230518064500-0.1.2l.4t1y.0.71jq1r9rbj@mahavavy.com>
Date: Thu, 18 May 2023 08:11:09 GMT
From: =?UTF-8?Q?"Kristi=C3=A1n_Plet=C3=A1nek"?= <kristian.pletanek@mahavavy.com>
To: <linux-nvme@lists.infradead.org>
Subject: =?UTF-8?Q?Tlakov=C4=9B_lit=C3=BD?=
X-Mailer: mail.mahavavy.com
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_011140_082455_88921C30 
X-CRM114-Status: UNSURE (   1.85  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Dobr=C3=A9 r=C3=A1no,

zaji=C5=A1=C5=A5ujeme technologii tlakov=C3=A9ho lit=C3=AD hlin=C3=ADku.

M=C3=A1me v=C3=BDrobn=C3=AD z=C3=A1vody v Polsku, =C5=A0v=C3=A9dsku a =C4=
=8C=C3=ADn=C4=9B se schopnost=C3=AD flexibiln=C4=9B p=C5=99esouvat v=C3=BD=
robu mezi lokalitami.

Na=C5=A1e lic=C3=AD bu=C5=88ky jsou v=C4=9Bt=C5=A1inou automatick=C3=A9 n=
ebo poloautomatick=C3=A9, co=C5=BE umo=C5=BE=C5=88uje v=C3=BDrobu velk=C3=
=BDch v=C3=BDrobn=C3=ADch s=C3=A9ri=C3=AD s vysokou flexibilitou detail=C5=
=AF.
=20
Poskytujeme podporu v ka=C5=BEd=C3=A9 f=C3=A1zi v=C3=BDvoje projektu, vyv=
=C3=ADj=C3=ADme strukturu detailu.

Cht=C4=9Bli byste mluvit o spolupr=C3=A1ci v t=C3=A9to oblasti?

Pozdravy
Kristi=C3=A1n Plet=C3=A1nek

