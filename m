From: joe@perches.com (Joe Perches)
Date: Wed, 09 Dec 2015 15:21:40 -0800
Subject: [PATCHv3] printf: Add format for 8-byte EUI-64 type
In-Reply-To: <1449702413-25598-1-git-send-email-keith.busch@intel.com>
References: <1449702413-25598-1-git-send-email-keith.busch@intel.com>
Message-ID: <1449703300.25389.95.camel@perches.com>

On Wed, 2015-12-09@16:06 -0700, Keith Busch wrote:
> MAC addresses may be formed using rules based on EUI-64, which is 2 bytes
> longer than a typical 6-byte MAC. This patch adds a long specifier to
> the %pM format to support the extended unique identifier.
> 
> Since there are multiple valid possible permutations of format specifiers,
> the decoding is done in a loop, and the default ':' separator is
> initialized at declaration time. A side effect of this allows 'F' and
> 'R' both be specified, so these are appended to the documentation.

Just thought of this:

An alternative is using a format of "%8phC"

Is there a use case for a bluetooth or FDDI EUI-64?
