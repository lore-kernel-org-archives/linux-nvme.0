From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Oct 2018 15:51:38 -0600
Subject: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.
In-Reply-To: <SN1PR04MB198440725CBB35D5EAAF94A4EAF60@SN1PR04MB1984.namprd04.prod.outlook.com>
References: <1539921985-17139-1-git-send-email-dong.ho@wdc.com>
 <20181019171713.GA25247@localhost.localdomain>
 <CAPrnrPAhfJmp48zNDgM3JYP2g0BbgAGDgdkB1OCotXHb_00FcQ@mail.gmail.com>
 <20181024162209.GA4461@localhost.localdomain>
 <CAPrnrPDdBinRXG_18ZBJp+FkFT3EWPDM4xC0vhgg+tOoiDJGcg@mail.gmail.com>
 <SN1PR04MB198440725CBB35D5EAAF94A4EAF60@SN1PR04MB1984.namprd04.prod.outlook.com>
Message-ID: <20181024215137.GA5138@localhost.localdomain>

On Wed, Oct 24, 2018@09:42:28PM +0000, Jeffrey Lien wrote:
> Yea, the intent is to copy 11 bytes into the string.  The zero byte/space is not needed so memcpy is probably the better solution.  

No, look again. The string terminator most certainly is needed the way
you're using it. It happened to work out since you've initialized the
temporary character array to all 0's, but there was no reason to even
allocate 4k stack space to hold a copy of that string instead of using
the pointing a 'const char *' directly to the literal.
