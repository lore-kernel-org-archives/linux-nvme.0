From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 Oct 2018 12:02:43 -0600
Subject: [PATCH 1/2] nvme-cli wdc plugin: Add get pfail dump command.
In-Reply-To: <SN1PR04MB1984D99829C68D3A2B8CAA76EAF70@SN1PR04MB1984.namprd04.prod.outlook.com>
References: <20181019171713.GA25247@localhost.localdomain>
 <CAPrnrPAhfJmp48zNDgM3JYP2g0BbgAGDgdkB1OCotXHb_00FcQ@mail.gmail.com>
 <20181024162209.GA4461@localhost.localdomain>
 <CAPrnrPDdBinRXG_18ZBJp+FkFT3EWPDM4xC0vhgg+tOoiDJGcg@mail.gmail.com>
 <SN1PR04MB198440725CBB35D5EAAF94A4EAF60@SN1PR04MB1984.namprd04.prod.outlook.com>
 <20181024215137.GA5138@localhost.localdomain>
 <7A7D3AF3-13B1-4569-BAC0-3689E5304F4E@wdc.com>
 <SN1PR04MB19845135D5239B300018EFA0EAF70@SN1PR04MB1984.namprd04.prod.outlook.com>
 <20181025160017.GA7035@localhost.localdomain>
 <SN1PR04MB1984D99829C68D3A2B8CAA76EAF70@SN1PR04MB1984.namprd04.prod.outlook.com>
Message-ID: <20181025180243.GC7035@localhost.localdomain>

On Thu, Oct 25, 2018@05:47:24PM +0000, Jeffrey Lien wrote:
> Keith, 
> Here's an updated patch, or just apply the version you had below.   They are identical.   Sorry for misunderstanding what you were trying to suggest.   

Okay, no problem. I'll go one step further and make this a 'const
char*' and update wdc_get_serial_name to declare the suffix as 'const'
since that is how it is used. My compiler didn't complain either way,
but I suspect some setting might not like casting a string literal to
a non-const pointer.
