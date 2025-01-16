Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B91AC02180
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7stgIKmiTDblq+OqjhHkL/tfKe48xpa2yz7a5pR6Sqs=; b=qq4WcwG0yeUEAv833UTQi1zcVF
	e0OyILIPNmQh6XRIebjMNbnpMBIZf0sELdvDyNkhmpQGeGD8BCPvyy78dNt3Zr2XU6qcL9nupAsdu
	urCyZ6TGwGRlq5ZxDXjbNEH0K+hBd8T32xDsTWLBUzXSYmK6hLFflwCLOJMMA/TcpZODY8GSCk1vN
	Uk0lQDVijP0b0o6dk+1xNjaejyfWGmacNyvsf/4qPCWq1dVVRkkx9BG8FnLvyc5b5Nkz6JGlNHMf3
	IcMBRAaRyom3uHSV3aXT4WNFhOonM17Jl66i12Ph8aKZFNiMgIOeWM0nFyxDAIHwYHdOEPZhGhnOh
	6BtO6Vag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYOBt-0000000Elfn-2A4C;
	Thu, 16 Jan 2025 11:37:37 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYOBr-0000000Elef-0Z6V
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 11:37:36 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-436a39e4891so4764895e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 16 Jan 2025 03:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737027453; x=1737632253; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7stgIKmiTDblq+OqjhHkL/tfKe48xpa2yz7a5pR6Sqs=;
        b=CXQG37tqQ3IO+B+eSHYlnn6Zx6a0oGGABAM21ASEPuKVhJg0HCeZWQYMO1lE6DSsBw
         m++rDZd7+EkYvr5oPI3Vh5OeJXTBYgVseIxU/8gePU9O5bX6eTAjXJL0MXS6cNgmPraL
         jU1Gm2F+q+mVf2xwRk+Bvr/M3PtjDwiij/aLhZEDFkMiYgerOf8G8zJj12INPoPUW8tL
         nee19yl0O2IR2wzHuadGzgtFyQJ+z22co7mT87G7O9ouVuIFzGS4QvTn2N2HrbC29XqY
         /k3GpwUVY3RpFeDfwOo9SrYYPm+QXuux4KT/m+u2UuATFK8jgvaq5jfs7i29TM+E2DCr
         9ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027453; x=1737632253;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7stgIKmiTDblq+OqjhHkL/tfKe48xpa2yz7a5pR6Sqs=;
        b=F8HS4U5QadKyTdsaCLos4SwTZpXWStZVqF/LJUIsfBCWxOVUN78SXjbAssi0739c4d
         nKpbVGfff3kshUfL1xsaSbt8sag4s3lR9bLiS5nM9QcwTZb+R91fEGPqyS9V2wrf2eXT
         2Z1V+zU4xMNJsL8KqWuDUg2JPhEGNDV98+7HSb10o2/4oXNPraEt7jNcxD0GRLAFON9o
         /Tu9I0cv0qQ6XqV7loS1q2V27MAJcGNreL3oEDiu7weUEtrDXn9ocLHUt6/SmV+Q5HkM
         3bdvN1+ifQy+e3al6k5xD2yOUUA4j0/WsrDJb4cp57ad3cyk7P+8LfSWxtsH42lVSYPX
         i7dw==
X-Forwarded-Encrypted: i=1; AJvYcCUTnY15G0X+FG2MLTlF1tU+FELUVgwlIIXhbfPxpwmMMjZw3io3Ut3ulSU3jTD5SE9C65Qf2Iv5fGgs@lists.infradead.org
X-Gm-Message-State: AOJu0YyH1C+FrmVp1oAvk0D94SfXWPBzCoXyUVUJhtLvfKlV3R+dOpjP
	swN+r4ArEiy0FlrJLsqSbtwBuho7Zm7w+kXw8kqaLWNkKOAdcyBzs441jsMO57s=
X-Gm-Gg: ASbGnct7k3oA0Oomo9tNfKcvVe9Y52KQKIQXWJGH/0idTlohr7IEzlNPjBVcAVh71b1
	FVWCM/WtbWifH5Aj7XWAeue76seb95y6fOPlH/P1EVk1cBKbxJ9ce76/9RZINK6XUeifeY7KxWS
	RRjR5WcXNBvEWfe5GA1FwKPz1Xd9ojwQCb8TbrNH1oEZlx4JkTqqoRk3dhuckRz1Bf8hAobYjkc
	1DHVs6A078ZIGRoHAH7jx7RhgGOhdbxcehik1Atmqvb2jvXAxVZwy8qFC80u11uG+lGc1vZkDs2
	wEOVnzvlXK+7VIMar/vY7Mu2bNPBbeYAfiCoU2opCr430TRh9bIUNLptDz/Cqaz+U+UGfdo6DYD
	lAO4owv+GhJju
X-Google-Smtp-Source: AGHT+IHwO2jJlAnxMchHosPjUJhphRNKR75DhQS708KRZDICK3q5Ej0rhK+BaRodG88L3q982CEqsw==
X-Received: by 2002:a05:6000:178d:b0:387:8752:5691 with SMTP id ffacd0b85a97d-38a87309d15mr28920725f8f.47.1737027452786;
        Thu, 16 Jan 2025 03:37:32 -0800 (PST)
Received: from ?IPv6:2003:de:3746:4600:ac00:378:25cc:9f2c? (p200300de37464600ac00037825cc9f2c.dip0.t-ipconnect.de. [2003:de:3746:4600:ac00:378:25cc:9f2c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b82ddsm20089008f8f.71.2025.01.16.03.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 03:37:32 -0800 (PST)
Message-ID: <737c9769145dae722b0274b2a09decf7ab474a26.camel@suse.com>
Subject: Re: [PATCH blktests] nvme/053: do not use awk
From: Martin Wilck <martin.wilck@suse.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Date: Thu, 16 Jan 2025 12:37:31 +0100
In-Reply-To: <20250116071754.1161787-1-shinichiro.kawasaki@wdc.com>
References: <20250116071754.1161787-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_033735_186583_E0C32148 
X-CRM114-Status: GOOD (  14.52  )
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

On Thu, 2025-01-16 at 16:17 +0900, Shin'ichiro Kawasaki wrote:
> Luis observed that the test case nvme/053 fails in his environment
> [1]
> due to the following awk error message:
>=20
> =C2=A0awk: ...rescan.awk:2: warning: The time extension is obsolete.
> =C2=A0Use the timex extension from gawkextlib
>=20
> To avoid the failure and reduce dependencies, do not use awk in the
> test
> case. Instead, introduce the bash function get_sleep_time() to
> calculate
> the sleep time. Also implement the controller rescan loop in bash,
> following Martin's original patch [2].
>=20
> [1]
> https://lore.kernel.org/linux-block/20241218111340.3912034-1-mcgrof@kerne=
l.org/
> [2]
> https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.co=
m/
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

LGTM

Reviewed-by: Martin Wilck <mwilck@suse.com>



> ---
> =C2=A0tests/nvme/053 | 34 ++++++++++++++--------------------
> =C2=A01 file changed, 14 insertions(+), 20 deletions(-)
>=20
> diff --git a/tests/nvme/053 b/tests/nvme/053
> index 3ade8d3..99dbd38 100755
> --- a/tests/nvme/053
> +++ b/tests/nvme/053
> @@ -12,8 +12,15 @@ DESCRIPTION=3D"test controller rescan under I/O
> load"
> =C2=A0TIMED=3D1
> =C2=A0: "${TIMEOUT:=3D60}"
> =C2=A0
> +get_sleep_time() {
> +	local duration=3D$((RANDOM % 50 + 1))
> +
> +	echo "$((duration / 10)).$((duration % 10))"
> +}
> +
> =C2=A0rescan_controller() {
> -	local path
> +	local path finish
> +
> =C2=A0	path=3D"$1/rescan_controller"
> =C2=A0
> =C2=A0	[[ -f "$path" ]] || {
> @@ -21,24 +28,12 @@ rescan_controller() {
> =C2=A0		return 1
> =C2=A0	}
> =C2=A0
> -	awk -f "$TMPDIR/rescan.awk" \
> -	=C2=A0=C2=A0=C2=A0 -v path=3D"$path" -v timeout=3D"$TIMEOUT" -v seed=3D=
"$2" &
> -}
> -
> -create_rescan_script() {
> -	cat >"$TMPDIR/rescan.awk" <<EOF
> -@load "time"
> -
> -BEGIN {
> -=C2=A0=C2=A0=C2=A0 srand(seed);
> -=C2=A0=C2=A0=C2=A0 finish =3D gettimeofday() + strtonum(timeout);
> -=C2=A0=C2=A0=C2=A0 while (gettimeofday() < finish) {
> -	sleep(0.1 + 5 * rand());
> -	printf("1\n") > path;
> -	close(path);
> -=C2=A0=C2=A0=C2=A0 }
> -}
> -EOF
> +	finish=3D$(($(date +%s) + TIMEOUT))
> +	while [[ $(date +%s) -le $finish ]]; do
> +		# sleep interval between 0.1 and 5s
> +		sleep "$(get_sleep_time)"
> +		echo 1 >"$path"
> +	done
> =C2=A0}
> =C2=A0
> =C2=A0test_device() {
> @@ -46,7 +41,6 @@ test_device() {
> =C2=A0	local i st line
> =C2=A0
> =C2=A0	echo "Running ${TEST_NAME}"
> -	create_rescan_script
> =C2=A0
> =C2=A0	while IFS=3D read -r line; do
> =C2=A0		ctrls+=3D("$line")


