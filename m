Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D941FC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 13:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565D1610CF
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 13:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 565D1610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:From:To:Date:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HRcTlSbQuLqjsQq+zJivUNF8HVFvsCq7Xei4ekn+2xY=; b=mDBzDk0jlWLB0gP73evn/S0ZBi
	pg43hKYuuYMVdF0mzeduxv8kQySZudlFXLKEUSUSHqQ/nkHPaqKO5WeUMjkBFfVtJ6h82ht7kO9vV
	q2M2hYu+yABDYusmc+ceG3/RxSI/S3O5hkpejCFxep6Nc/cKCyl4xOsWEZ3m59bG8MXkQSI+HZEmF
	RRSOAV/zUoRP/0/i2aqdwXdliIUS4+n4VXzZRCyhpImwChB9/nG2nF4w7gMXPQ+KcYWugxfe+GMEb
	UzE/yu6RLvP0tBFVuPtXqZRD53FLxOPZeXk2rifgO4/kYl474GESrFxF8zauLE34b5Ew1+DrC5MG3
	TnDgm6aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mU7SH-00Gbi9-Uw; Sat, 25 Sep 2021 13:11:01 +0000
Received: from mail-4318.protonmail.ch ([185.70.43.18])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mU7SD-00Gbh7-Ng
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 13:11:01 +0000
Date: Sat, 25 Sep 2021 13:10:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1632575444;
 bh=Bn/10dq7x8kiU4jAeigMgLyL1jyoLt0qpxzmZqwig8Q=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=uryIr0DWCAMk6jkK3iSNk+fDuehcafcc7iD93nYGQVFYlr5ShzOzkXAkKUosb1amF
 KSGIlqk1MO7nJvU8IukG0fyE8gHhxj3rMMXJZcBYsYJLv3w/uz2FteueutJA4eNIiS
 tyh0UvJfN1BqVtm1uACQLYJT3xUctBcDIk8VYlI0=
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Orlando Chamberlain <redecorating@protonmail.com>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "gargaditya08@live.com" <gargaditya08@live.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hare@suse.de" <hare@suse.de>, "dwagner@suse.de" <dwagner@suse.de>,
 "hch@lst.de" <hch@lst.de>
Subject: [REGRESSION] nvme: code command_id with a genctr for use-after-free
 validation crashes apple T2 SSD
Message-ID: <cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_yUMSB9H47XNrREPo1cfCTbZLKAODEeONvts7ZCFIlU"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_061057_993049_79CA2A40 
X-CRM114-Status: GOOD (  15.64  )
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
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.

--b1_yUMSB9H47XNrREPo1cfCTbZLKAODEeONvts7ZCFIlU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Commit e7006de6c238 causes the SSD controller on Apple T2 computers to cras=
h
and prevents linux from booting.

This commit implemented a counter that is stored within the NVMe command_id=
,
however this counter makes the command_id higher than normal, causing a pan=
ic
on the T2 security chip that functions as the SSD controller, which then
causes the system to power off after a few seconds.

This was reported on bugzilla here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D214509 but it was not origina=
lly
classified as NVMe (when the report was created it was unknown what was
causing it), so I don't know if it notified the NVMe mailing list when it
was later reclassified to NVMe. Sorry if you've already seen this issue.

The T2 security chip (which is the SSD) has this line in its crash log (the
rest of this log is in an attachment on the bugzilla report):

panic(cpu 1 caller 0xfffffff028d884ec): ANS2 Recoverable Panic - assert fai=
led: [7447]:command id out of range error (cid =3D 4120), status_reg: 0x200=
0 - Null(2)

This is the entry in lspci -nn for the ssd:

04:00.0 Mass storage controller [0180]: Apple Inc. ANS2 NVMe Controller [10=
6b:2005] (rev 01)

This commit was included in 5.14.6 and backported to 5.10.67, but does not
occur in 5.14.5 and 5.10.66. I am on a MacBookPro16,1, the crash has been
reproduced on a MacBookPro16,2 as well. I have been able to reproduce on Ar=
ch
Linux with vanilla kernel 5.10.67 (others have gotten it on 5.14.6) with no
DKMS modules, and I bisected it to that commit
(e7006de6c23803799be000a5dcce4d916a36541a).

I've tried to modify the genctr so that it is in the other side of the
command_id (which I thought might make the command_id's lower) with the pat=
ch
below, but it did not prevent the crash.

Regards,
Orlando Chamberlain

--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -489,17 +489,20 @@ struct nvme_ctrl_ops {

 /*
  * nvme command_id is constructed as such:
- * | xxxx | xxxxxxxxxxxx |
- *   gen    request tag
- */
+ * | xxxxxxxxxxxx | xxxx |
+ *   request tag    gen
+ *
+ * The gen is at the end as the SSD in Apple T2 Computers
+ * crashes when the command_id is too high.
+*/
 #define nvme_genctr_mask(gen)                  (gen & 0xf)
-#define nvme_cid_install_genctr(gen)           (nvme_genctr_mask(gen) << 1=
2)
-#define nvme_genctr_from_cid(cid)              ((cid & 0xf000) >> 12)
-#define nvme_tag_from_cid(cid)                 (cid & 0xfff)
+#define nvme_cid_install_genctr(gen)           (nvme_genctr_mask(gen))
+#define nvme_genctr_from_cid(cid)              ((cid & 0x000f))
+#define nvme_tag_from_cid(cid)                 ((cid & 0xfff0) >> 4)

 static inline u16 nvme_cid(struct request *rq)
 {
-       return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
+       return nvme_cid_install_genctr(nvme_req(rq)->genctr) | (rq->tag << =
4);
 }

 static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
--b1_yUMSB9H47XNrREPo1cfCTbZLKAODEeONvts7ZCFIlU
Content-Type: application/pgp-keys; name="publickey - redecorating@protonmail.com - 0xEE1BCCD7.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - redecorating@protonmail.com - 0xEE1BCCD7.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGKzNDYUlC
Q0FDdS9jQVp0ZDhKeFY0bVVWU1B6VnBQSlRLUEg2Q3BhN1JkMHJCT1pUK3lzNXJBDQpzM01hQmc0
K3hHYWJDL0w1eWdoalUwOXVrbndQYUh5UEJOWXlYMTZEMHpYL05SVHBGeEpkOGYxSmFMNzANCkpB
V0pWOFdCVnZFOGZ4U3VZNGFmVW1qQStpL3N5VzNHSG1IUmVySC84Z09ySHFVOTQ3TjczZWVEcVlu
NQ0KSXNhQUJGYW1yVkRqNmhhZzluN1lyWVVVRkh1R1I3Vm9sQXNSck5OcDF1ZTFqVjg1SUV5MGxp
VUM2ZkJkDQpsR1NtcVg3WStxOVo3QUxlOHVrMEIySk5QWktGRSsvbnRNRHo2TEVraGdzWE42YjFX
MGk3em55cVV3cmwNCnFoZEoxcUU5MURLQWpLZ09sR0lqd2tYOUprRGJObEh3VWxCOEFUc1EvMTJB
ejBCS3BhVnhqVCs1QUJFQg0KQUFITk9YSmxaR1ZqYjNKaGRHbHVaMEJ3Y205MGIyNXRZV2xzTG1O
dmJTQThjbVZrWldOdmNtRjBhVzVuDQpRSEJ5YjNSdmJtMWhhV3d1WTI5dFBzTEFqUVFRQVFnQUlB
VUNYN2NKb2dZTENRY0lBd0lFRlFnS0FnUVcNCkFnRUFBaGtCQWhzREFoNEJBQ0VKRVBOYzNOTm10
ZmxXRmlFRTdodk0xd3J4YnFSSjhjbVM4MXpjMDJhMQ0KK1ZZQStBZi9YeHVQdTVZS1ZYK0RlcUVl
c3lSbVBlTlVmVW9KaVNWS2FvNzdqV1NnZzhZTHRqZGdyZ3VRDQpVaG5qdXhFSjdpVWlBR1FTM1J3
LzhUMzVKOXpyd01jbXhpMnE4ZjY3VEJVNkVyRTJ4TkpIcXhjbldiaUgNCm5aeDBFYStwUTY4bUVS
ay9MZHlOUXhZSkM4cEsyTHg2WVdQdjFFN2VsTllJR2Q3WXlNdlY1YmFUTmtqbQ0KVDdsMTJCbnRs
RlFqYWNtY1RtWUd1aUdwWWdlNjQ0dFpPc1ZrbDhMd0FXT0VTTzkweGlZNW40Z3oyVXpTDQp0eGdI
cFJ5TWdSSnNwVTRlWEpxRWIxdExpeW1DbDVxeHpybnVEM0dSZDAwZ0VBUmVsUktGUWxVQW9UdWEN
Ck84cmVYclZwOTRMb1YzcDIrR0dtR1gyU3hWSVJKVzk1VlVBOVNXaDRrRGhLLzdlMDc4N0FUUVJm
dHdtaQ0KQVFnQTNLR1BGdksyV29yajQ3Wmo5azdrd2Y0T2JrK0p4MFdoMlNZUFVibmlBYzUxeUFy
S3dqRkJncE5PDQpBYnBGNmRHeThJeEl6YnkybVlTSmczYmpaeXNBNnZDU3FjSXhvZ2hnelppL3NG
amZ6dUVmVUQ5RlhPTnYNClgxRk9hUEo3Z2YvcWVqYUJYVGZTY2JlRGM1YTdNQ3Vqd0hrSzNuWlRL
WGtWa1l0NGVVTnA2cWkwcTdqZw0KQXJMRnVLT2lzTEx2VkpTVlZQZk5UWE9HaEdTS1FJc0xEamo2
cWp1VWFOckgrMW1kZGlubkM4TGh1dUpVDQpxNzl0d0NYWEVoZGxXYmk1MFFiTnM5UHdCYnQvNUVH
YUF0YlNzRHpRdHhvZDZpalRIc1Y4SGlkUmpmZ1gNCm13eTVMaXphOEhtWnQ5UmpxajdablpaQmJx
ZXFqSVJQa1ZQRlR1SFg2SXIwY3dBUkFRQUJ3c0IyQkJnQg0KQ0FBSkJRSmZ0d21pQWhzTUFDRUpF
UE5jM05ObXRmbFdGaUVFN2h2TTF3cnhicVJKOGNtUzgxemMwMmExDQorVlozYlFmL1Y3bUxpaDFl
a2g5VlJIbkxkT3ZPY3Ezbjh6SlN0WFVDYmV2eTZOMjNvZmxrTE43VTlDc1INCmRsUmY2dCszK2Ju
ajNpWEhmNkdrOERLbzEwS3lQTzFMRlJjR3lSZjZsNHlRL3FvdVNqa0ttVTJOc0kvZQ0KeTVBemNL
VElyOTAxZ0hJeU9GV2IyNjVTQ1B0Tld0SGI4bTFpUUxSdXZCNndqSTk4MGdvdVdSL1lXOFFlDQpE
bUlBa2RNSmJvTThyTnZvVFN5UHhqS1VFN08ySDluVVhqRGcxQk5NbW9Wc2w1SngyKzNtNlQ4VDVs
eG0NCkkzb2cwYWdKd04rMnVKRW5JNmIrTnlMZ21BS0dPWVppd1psckxTb0UrQ2R5dnBNM001L1Zp
cDZqbGJaaw0Kbmk0Tm1JdkVua3NSSnRKMkpNcXJORWFuVXFGdis3cVVkejgxY3BEajJ6K1hNMmts
ZWc9PQ0KPWh4eEcNCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0NCg==

--b1_yUMSB9H47XNrREPo1cfCTbZLKAODEeONvts7ZCFIlU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--b1_yUMSB9H47XNrREPo1cfCTbZLKAODEeONvts7ZCFIlU--


