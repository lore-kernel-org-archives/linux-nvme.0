From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 06 Mar 2017 11:49:46 -0800
Subject: [PATCH v2] fabrics: Handle space-padded TRSVCID and TRADDR fields
In-Reply-To: <20170306193621.11190-1-roland@kernel.org>
References: <20170306193621.11190-1-roland@kernel.org>
Message-ID: <1488829786.3733.8.camel@linux.intel.com>

On Mon, 2017-03-06@11:36 -0800, Roland Dreier wrote:
> From: Roland Dreier <roland at purestorage.com>
> 
> The TRSVCID and TRADDR fields in the discovery log page are defined
> as ASCII strings, which according to the NVMe standard means they
> should be space-padded rather than NUL-terminated.
> 
> The current nvme-cli code will print all the spaces and possibly some
> garbage from the next field.??For example this causes "connect-all"
> to write strings that get rejected with "malformed IP address passed."
> 
> Fix this by only writing the contents of these fields until the last
> non-space character, and limiting the length to the size of the field.
> 
> Signed-off-by: Roland Dreier <roland at purestorage.com>

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

(already pulled into nvme-cli by Keith).
