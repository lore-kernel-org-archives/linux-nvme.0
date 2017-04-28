From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 28 Apr 2017 07:28:12 -0700
Subject: [PATCH v2] nvmet core: skip flags checks on fabric commands
In-Reply-To: <20170428030414.27185-1-jsmart2021@gmail.com>
References: <20170428030414.27185-1-jsmart2021@gmail.com>
Message-ID: <20170428142812.GA30820@infradead.org>

On Thu, Apr 27, 2017@08:04:14PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> The core layer validates nvme command flags (w0 byte 1) values before
> decoding opcodes. On fabric commands the flags field is reserved.
> Current validations require NVME_CMD_SGL_METABUF or NVME_CMD_SGL_METASEG
> to be set. If host sets flags to 0 as reserved field, command fails.
> 
> Exclude fabric commands from flags checks.

Eww.  I'd rather talk to the working group and get this fixed in an
errata.  Treating a field special for fabrics command does not make
sense.
