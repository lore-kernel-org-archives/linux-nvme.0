From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 14 May 2019 17:22:16 +0200
Subject: [PATCH] nvme-cli: align comments for struct telemetry_log_page_hdr
In-Reply-To: <1557846878-25595-1-git-send-email-akinobu.mita@gmail.com>
References: <1557846878-25595-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <70b80155-d4a8-b53e-7022-0f5f704b1338@acm.org>

On 5/14/19 5:14 PM, Akinobu Mita wrote:
> Align the field member comments for struct telemetry_log_page_hdr.
> This also uses tabs instead of spaces to align field members.

Hi Akinobu,

Have you considered to use the kernel-doc syntax instead of aligning the
comments? See also
https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt.

Thanks,

Bart.
