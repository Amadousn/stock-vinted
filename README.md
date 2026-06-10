# Stock Vinted — version partagée (Supabase + Vercel)

Stock partagé en temps réel entre toi et ton transporteur. Tout le monde voit les mêmes articles ; une modif apparaît instantanément chez les autres.

## 1. Créer la base Supabase (5 min)
1. Va sur https://supabase.com → **New project** (note bien le mot de passe DB).
2. Une fois le projet prêt : menu **SQL Editor** → **New query**.
3. Copie-colle tout le contenu de `supabase-setup.sql` → **Run**.
   (crée la table `articles`, le bucket `photos`, le temps réel et les accès publics)

## 2. Récupérer tes clés
**Project Settings** (roue crantée) → **API** :
- **Project URL** → `https://xxxx.supabase.co`
- **anon / public key** → longue clé `eyJ...`

## 3. Configurer le fichier
Ouvre `stock-vinted-cloud.html`, descends jusqu'à la section **CONFIG** (vers le bas) et remplace :
```js
const SUPABASE_URL      = 'https://TON-PROJET.supabase.co';
const SUPABASE_ANON_KEY = 'TA_CLE_ANON_ICI';
```
Teste en local : double-clic sur le fichier. Le badge doit passer à **« En direct »** (vert).

## 4. Déployer sur Vercel
Option simple (drag & drop) :
1. Renomme `stock-vinted-cloud.html` en `index.html`.
2. Mets-le seul dans un dossier.
3. Va sur https://vercel.com → **Add New → Project → Deploy** (ou glisse le dossier sur vercel.com/new).
4. Tu obtiens un lien `https://ton-stock.vercel.app` → envoie-le à ton transporteur.

## ⚠️ Sécurité (lien sans login)
- La clé **anon** est publique (normal, elle est faite pour le navigateur).
- Mais avec les accès publics, **toute personne ayant le lien Vercel peut voir, ajouter, modifier et supprimer** le stock + uploader des images.
- **Garde l'URL Vercel privée** : ne la partage qu'avec ton transporteur, ne l'indexe pas.
- Si un jour tu veux verrouiller : on passe à un **mot de passe partagé** ou à de **vrais comptes** (auth Supabase). Dis-le moi.

## Sauvegarde
Storage Supabase = tes photos. Table `articles` = tes données. Tu peux exporter la table depuis le dashboard (Table editor → Export) si besoin.
