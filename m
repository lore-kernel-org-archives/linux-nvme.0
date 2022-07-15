Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A912C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 23:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8EIKviJpWn6WXvA0ocp7Iy+6MkS1Q6PiUMTHbdBoOI=; b=EKOX+4RB5PW3dKSGSP4ZMImMXN
	y7WMXvuPodlUo/2VqFBmlnoRkjn7Zwbuae4gDzAn2F0CZZKMBa/8xnk7Fayvz4ZuLdh7lLnIXAXxs
	f+luoKZJtiypEu1HCg48DqdiN6lUpN69U/VUb1zUl55uEhLkg0OodWAG/1S/Cf3QFMRTZt340p4Ee
	A1Wa7dqJXq/yMmzxJLrun+DwU4SjWMB+KUrVcJo+wDWTdCJ1a0h+2AtlUmSycus32/eqlOTxOpSLH
	Kbi+a48DPSbLXnuAPENzh4DHN4GwnMQUwerlIJhYOlCAJsjSX1Rqtf6X3G3RPgD3Cw2LcOPxJ22TR
	/YSn7WXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCUkK-00BACC-MW; Fri, 15 Jul 2022 23:29:20 +0000
Received: from sonic308-16.consmr.mail.ne1.yahoo.com ([66.163.187.39])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCUWL-00B2h8-K0
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 23:14:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657926889; bh=R8EIKviJpWn6WXvA0ocp7Iy+6MkS1Q6PiUMTHbdBoOI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ffm+xBCJ10KkkHHnpthfdst8le/V6cj4NwudhAbyFcXJfrYsPAjoOSTsk8S+CNw+KsFv1ndXMRldm2wMORuaF+zXOwgfPsITk8hBfK0eR3ApudsxM1D34mmoBAQAvPucbin9JG4l0nTWlrC+Y1jRJE7TipJrhBqVU3O/AtxIZEmUl6G/UYuM5fSSJB00A9rSNiN929c23J3DLl0sQOrmVxGh4GDtjawjBOpc2qmykMRz56epE14m2qSQSV8IYF5XCZGZPUsZpfUklCRcNYhsKWPBE25ygEE/8jbtN6vWPIDib+FVeAWHvTnGc9xXS2hTeaSRLJub4NN0AwbUiMFKtg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657926889; bh=B1bXHFR5E1nXSeE/G6XKIdP3YYsr+IXcMjMAnL+lVHZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QsiErGTb/5A0EgB5mIB3KHz1mVaOMNkVRXGyNBrhfENUudC1OsQouPyTOP82cfBoPOCUhMJqdvlvbV3twh/OK2wNYsKn7sAkDWvVGEv2Jq1an+hLNysfax/UbLTHQdu9G5PDU2JAmj3CtEU5zpPj5Bp0GlbEcljNSUrJcSSR4Q9bWId2Vzdq10FBs46BJHRKGyu+/Boqu8nHRJlD6CNVmYUdZIEL8rOWU8Ypzyl1TvHj+0LEjL55xu6vFSMD1sNil4C66ENatk3e9ky9vpvczQcPlaSSVFv+eWf/Iy2VQ+xTaofwjPme1uI+MDJyI1cQ4jwcSSMpqL3vUbd2ynS+Bg==
X-YMail-OSG: wvcK4usVM1n4LwK3_eQbCiFLdfVUS9Xm5zN4Mekmx0aF2OYgOR.XZaacK340ssP
 FRWv98Jd43a4aurXvEukipBLLjndmke40.ghFbR01vcwMpje8LDCN0eyOaTa2N_MwJZTriNm728N
 7S2x2gTdcZPnPat9cXlf6fsPKoP6F4B9u6JNCoLmr7epW6603qbjUf1Ihg5ECGLbQNtqFWw5Mynh
 xR.WTqeOVMPE5_7lerhXx4n9UYHW2hQv28A5nHy2x6zo5oPEdE0GAPnrHMpCN.2e50DGs98bFOek
 L5hsTwqGZ3nKCWUgj07x34C8fj5Zox2vod9KhPZTroU9CrHiGpXLN.tfmH2p1hRtnfG2n7tOTWoJ
 ivKeFdxC1UiEEjxKHrGLawC4ha3OTSDLALopkUfqmYSUJfC7Yyq3_c0xQxo290VTRRhfdj4MSfew
 drIz7ntK6TnrpFd5Prf606Te.tmep8MpDTQbaTXYVlmhodZ24y0.hIuMSu_ExCrWT8xVLNzXiJvz
 RJAY8HJ5yeVZelSlIXKojfoT7CcxdazmU3rhvLxtpSIEa9kGjsfJqOpuD1buXkdctlVcyqoJsBWx
 fRuMJ_TM1bqiTTil6Kc4p7_CveNMW5FMR7bx4aXwW5zpaQk7ObICs_DsAcA4jU_ib70fUgv.djBy
 6e7SEILLHL7gcQMWE.jAF9bSNhmHyjrKab536Ybg96O5aaPpmw4H6SszmZoSG9b8mg769w5mfPQk
 rBPUbx3Xc2IKIWSvkOsqLbOFuGN4QvSde_r3C9xwc7BMWgECvcdMxnzKGFqy9Ocg3SEDnSnbAtFW
 _IHKzCF6xhDfKZZrBZl0ZhTpHuSCK8oWEkXEEus.HWEyuvzJVE7NG9aNGVVbanxqevwB35JsUZqv
 uMWAknFMzIL2SFuWwyqJWwsifnNLjM.636nvRp6H5LGBXVhOj.T6mFQO076kxK6poPkkpiTjqGXo
 5I.1z3qyq_Ec7C4evzSoYT4Q3Agv_6jxJ0YQcdz9RtXfIVoTw7lSWQBed7nzhsCBG2r_ahckbE_8
 bOFxPZffQo_T_Arx2v8UTu4sKLIMtfLISFk_9KjvNxelVQ3cRRvnm7y_Uq2_3lYWtBHV2I1PSinc
 THeJb6y9K2aC4TdD6P2v3CBe9HoJKurFmxAWhcIYAnvRIJ9RcVv192xcdklc3ZTvoseMqLStxJHz
 Paj1Qk4k0R60FSpuRdVjinwPquYHRFZtOsG00sgGrY4R9ejUdCBPpxJZJ15loIa4a.cExGePO.yi
 s4UTVDswxKVUgIRlHcjYkHzXrXQkFB.f5J9Ouwtml3PRMqCGQ_JJ74zwE9Vqogan.J6nKnnCzPTX
 qkgWpB2TCu0QIYVihOXvPg6ZhiKHejF7BvcqCt6n6r10EWP9FvVV3VDwi1VWtGm0QNdIWn3LHLDh
 SHeEr72eoMNwL9340LYR8LwQl2yWPtlwsZ2MXLCg_rl0rhKHHzzr6Z_3lo3jEzP10PCqrlrcKW5l
 kFfZPmnEUyN_3xc0rTMJEMh0tMYiMjVE42ckYshLMd_XhsN7wXD4U_2kArFIe0Ro2BV3xM7Nm3wR
 0uo8JCFLXIfotP8cSbej60ACH946t9lJNFP7M05agkaP1hjCqplM7pm9Wqqj9WBI.Tf9R.CAovZ1
 xJja821Hs6_ZYkbBAi5BBNNGft_XL_FDXt7ACZecpyc.9lAVNomM_ouqMcTz9dL0z1pYJEHaCI0C
 rhW.XGeXSzIri5lATDintrhtblM38XpHaZF_VA4O3cpLHWP8M.OSjrG8s4MSuFmzXks64RAu_Vot
 E1_26L9_snORIvIocuH7V.4phIk4uNSi7a88kWhc7c8jsSlfMs0d_nDJk95CRa_owB.wyats.v5P
 gCZjPxoycdWvO4DyS3DEh6jiJUgJc8REWQPsDexaEDF.xwl2isO_AG1XQGBW045Yoga8m_Z_gXU0
 Qn9.y7hz3ixWvYkj.GIfqIe1XdTpWOfA8VFvlQLnd346ce7ZwToDgY6ykOTB3GBxB81.aZOHUnmR
 XnQJU4qKhqfmKgfDdFCrh1d5djT.aob9NcLmoRhFvV8au2lG_nDh2QCtVPx_oOOe8X_6LGtHLeAd
 WBfuuUYj2IVjcLbBqp6oq7mbcHqTzkOf1a56HV4Ji8glbnljXWWpBAlbAQ4oBb.WQ9ZZSHqxBC79
 Q0OlAgJE70lT6oJ8hAjILQKISw.OhfpHj8kr8XlKiIoP8bu4Sv7_mCvwGlHCTnE0IOXBzw_jzodh
 tk2O7cI5ISRWbgTswem3CpVC5ry.kvJCdqbW9_bTWOE7L
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Jul 2022 23:14:49 +0000
Received: by hermes--production-gq1-56bb98dbc7-28prh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7cd21de8b1e1f563320f75e46f114243;
          Fri, 15 Jul 2022 23:14:48 +0000 (UTC)
Message-ID: <d8912809-ffeb-8d88-3b6b-fd30681ad898@schaufler-ca.com>
Date: Fri, 15 Jul 2022 16:14:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file
 op
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: joshi.k@samsung.com, linux-security-module@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, a.manzanares@samsung.com, javier@javigon.com,
 casey@schaufler-ca.com
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <566af35b-cebb-20a4-99b8-93184f185491@schaufler-ca.com>
 <e9cd6c3a-0658-c770-e403-9329b8e9d841@schaufler-ca.com>
 <4588f798-54d6-311a-fcd2-0d0644829fc2@kernel.dk>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <4588f798-54d6-311a-fcd2-0d0644829fc2@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_161453_748216_B9C039B0 
X-CRM114-Status: UNSURE (   4.74  )
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

On 7/15/2022 4:05 PM, Jens Axboe wrote:
> On 7/15/22 5:03 PM, Casey Schaufler wrote:
>
>> There isn't (as of this writing) a file io_uring/uring_cmd.c in
>> Linus' tree. What tree does this patch apply to?
> It's the for-5.20 tree. See my reply to the v2 of the patch, including
> suggestions on how to stage it.

A URL for the io_uring tree would be REAL helpful.



