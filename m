From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Dec 2015 15:06:09 +0000
Subject: [PATCHv3] printf: Add format for 8-byte EUI-64 type
In-Reply-To: <1449703300.25389.95.camel@perches.com>
References: <1449702413-25598-1-git-send-email-keith.busch@intel.com>
 <1449703300.25389.95.camel@perches.com>
Message-ID: <20151210150609.GA23337@localhost.localdomain>

On Wed, Dec 09, 2015@03:21:40PM -0800, Joe Perches wrote:
> On Wed, 2015-12-09@16:06 -0700, Keith Busch wrote:
> > MAC addresses may be formed using rules based on EUI-64, which is 2 bytes
> > longer than a typical 6-byte MAC. This patch adds a long specifier to
> > the %pM format to support the extended unique identifier.
> > 
> > Since there are multiple valid possible permutations of format specifiers,
> > the decoding is done in a loop, and the default ':' separator is
> > initialized at declaration time. A side effect of this allows 'F' and
> > 'R' both be specified, so these are appended to the documentation.
> 
> Just thought of this:
> 
> An alternative is using a format of "%8phC"
> 
> Is there a use case for a bluetooth or FDDI EUI-64?

*facepalm*

I didn't know that format, but it satisfies my needs. I am not aware of
bluetooth or fddi using eui64, so I've no problem withdrawing the patch.
I'll just fix up the one that depended on it.
